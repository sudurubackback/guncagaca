package backend.sudurukbackx6.ownerservice.domain.owner.service;

import backend.sudurukbackx6.ownerservice.common.error.code.ErrorCode;
import backend.sudurukbackx6.ownerservice.common.error.exception.BadRequestException;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.SetStoreIdFromOwnerRequest;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.OwnerInfoResponse;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.request.SignInReqDto;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.request.SignUpReqDto;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.request.UpdatePwReqDto;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.response.OwnerSignupEvent;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.response.SignInResDto;
import backend.sudurukbackx6.ownerservice.domain.owner.entity.Owners;
import backend.sudurukbackx6.ownerservice.domain.owner.repository.OwnersRepository;
import backend.sudurukbackx6.ownerservice.encoder.Encrypt;
import backend.sudurukbackx6.ownerservice.jwt.JwtProvider;
import backend.sudurukbackx6.ownerservice.jwt.TokenDto;
import backend.sudurukbackx6.ownerservice.mail.service.MailSenderService;
import backend.sudurukbackx6.ownerservice.redis.util.RedisUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.mail.MessagingException;
import java.io.IOException;
import java.util.Optional;

@Service("OwnerService")
@Transactional
@RequiredArgsConstructor
@Slf4j
public class OwnerServiceImpl implements OwnerService {

    private final OwnersRepository ownersRepository;
    public final MailSenderService mailSenderService;
    private final JwtProvider jwtProvider;
    private final RedisUtil redisUtil;
    private final Encrypt encrypt;

    @Override
    public SignInResDto signIn(SignInReqDto request) {
        //로그인
        Optional<Owners> optionalOwners = ownersRepository.findByEmail(request.getEmail());

//        System.out.println(optionalOwners.get().getEmail());

        if (!optionalOwners.isPresent()) {
            throw new BadRequestException(ErrorCode.NOT_EXISTS_OWNER);
        }
        
        //비밀번호 확인 로직
        if(!encrypt.isMatch(request.getPassword(), optionalOwners.get().getPassword())){
            throw new BadRequestException(ErrorCode.USER_NOT_MATCH);
        }

        TokenDto accessToken = jwtProvider.createAccessToken(request.getEmail());
        TokenDto refreshToken = jwtProvider.createRefreshToken(request.getEmail());

        redisUtil.saveRefreshToken(request.getEmail(), refreshToken.getToken());


        return SignInResDto.builder()
                .accessToken(accessToken.getToken())
                .refreshToken(refreshToken.getToken())
                .build();
    }

    @Override
    public void signOut(String header) {
        //로그아웃
        String email = jwtProvider.extractEmail(header);
        redisUtil.deleteRefreshToken(email);
    }

    @Override
    public SignInResDto refreshAccessToken(String header) {
        //refresh token이 살아있는지 확인하고 accesstoken을 발급한다.
        String email = jwtProvider.extractEmail(header);
        String redisToken = redisUtil.getRefreshTokens(email);
        System.out.println("redisToken : "+redisToken);
        if(redisToken==null || redisToken.isEmpty() || !redisUtil.isMatchToken(email, header)){
            throw new BadRequestException(ErrorCode.NOT_VALID_REFRESH_TOKEN);
        }
        //이제 검증 완료! 그럼 새로 acceestoken발급 시작!
        TokenDto accessToken = jwtProvider.createAccessToken(email);
        TokenDto refreshToken = jwtProvider.createRefreshToken(email);

        //refreshtoken redis저장 및 갱신
        redisUtil.saveRefreshToken(email, refreshToken.getToken());

        return SignInResDto.builder()
                .accessToken(accessToken.getToken())
                .refreshToken(refreshToken.getToken())
                .build();
    }

//    @Override
//    public Owners findByEmail(String email) {
//        return ownersRepository.findByEmail(email).orElseThrow(() -> new BadRequestException(ErrorCode.NOT_EXISTS_OWNER));
//    }

    @Override
    public OwnerInfoResponse ownerInfo (String token){
        Owners owners = jwtProvider.extractUser(token);
        return OwnerInfoResponse.builder()
                .email(owners.getEmail())
                .tel(owners.getTel())
                .storeId(owners.getStoreId())
                .build();
    }

    @Override
    public Long ownerStoreId(SetStoreIdFromOwnerRequest request){
        Owners owners = ownersRepository.findByEmail(request.getEmail()).orElseThrow();
        owners.setStoreId(request.getStoreId());
        return request.getStoreId();
    }
    /*@Override
    public void toggleValidStatus(String email) {
        Owners owner = ownersRepository.findByEmail(email).orElseThrow(() -> new BadRequestException(ErrorCode.NOT_EXISTS_OWNER));
        owner.changeValidation();
    }
*/
    @KafkaListener(topics = "adminOwner", groupId = "owner")
    public void subscribeEvent(@Payload String eventString) {
        // json으로 역직렬화
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            OwnerSignupEvent ownerSignupEvent = objectMapper.readValue(eventString, OwnerSignupEvent.class);
            syncSignup(ownerSignupEvent);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
    }

    public void syncSignup(OwnerSignupEvent ownerSignupEvent) {
        Owners owner = Owners.builder()
                .email(ownerSignupEvent.getEmail())
                .password(ownerSignupEvent.getPassword())
                .tel(ownerSignupEvent.getTel())
                .build();
        ownersRepository.save(owner);
    }
}
