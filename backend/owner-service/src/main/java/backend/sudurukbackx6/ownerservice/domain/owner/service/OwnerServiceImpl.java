package backend.sudurukbackx6.ownerservice.domain.owner.service;

import backend.sudurukbackx6.ownerservice.common.error.code.ErrorCode;
import backend.sudurukbackx6.ownerservice.common.error.exception.BadRequestException;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.request.SignInReqDto;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.request.SignUpReqDto;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.request.UpdatePwReqDto;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.response.SignInResDto;
import backend.sudurukbackx6.ownerservice.domain.owner.entity.Owners;
import backend.sudurukbackx6.ownerservice.domain.owner.repository.OwnersRepository;
import backend.sudurukbackx6.ownerservice.encoder.Encrypt;
import backend.sudurukbackx6.ownerservice.jwt.JwtProvider;
import backend.sudurukbackx6.ownerservice.jwt.TokenDto;
import backend.sudurukbackx6.ownerservice.mail.service.MailSenderService;
import backend.sudurukbackx6.ownerservice.redis.util.RedisUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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
    public void signUp(SignUpReqDto signUpReqDto) throws IOException {
        //해당 이메일이 먼저 존재하는지 확인
        Optional<Owners> exitOwner = ownersRepository.findByEmail(signUpReqDto.getEmail());

        if (exitOwner.isEmpty()) {
            //이미 가입된 회원이 없으면? 회원가입 진행한다.
            Owners owner = new Owners(signUpReqDto.getEmail(), encrypt.encrypt(signUpReqDto.getPassword()), signUpReqDto.getTel());
            System.out.println("암호화 : "+encrypt.encrypt(signUpReqDto.getPassword()));
            ownersRepository.save(owner);
        } else {
            throw new BadRequestException(ErrorCode.USER_EXISTS);
        }
    }

    @Override
    public void sendAuthCode(String email) throws MessagingException {
        //이메일로 인증 코드 전송
        mailSenderService.sendCode(email);
    }

    @Override
    public boolean checkAuthCode(String email, String code) {
        return mailSenderService.checkCode(email, code);
    }

    @Override
    public boolean checkValidEmail(String email) {
        Optional<Owners> exitOwner = ownersRepository.findByEmail(email);

        if(exitOwner.isPresent()) return false;

        //존재 한다면 이메일 양식이 맞는지 확인
        return email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$");
    }

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
    public void resetPassword(String email) throws MessagingException {
        Optional<Owners> ownerOptional = ownersRepository.findByEmail(email);
        Owners owner = ownerOptional.orElseThrow(() -> new BadRequestException(ErrorCode.NOT_EXISTS_OWNER));
        String newPassword = mailSenderService.sendPassword(email);
        owner.changePassword(encrypt.encrypt(newPassword));
    }

    @Override
    public void changePassword(String token, UpdatePwReqDto updatePwReqDto) {
        Owners owner = jwtProvider.extractUser(token);
        if(!encrypt.isMatch(updatePwReqDto.getPassword(),owner.getPassword())){
            throw new BadRequestException(ErrorCode.USER_NOT_MATCH);
        }

        owner.changePassword(encrypt.encrypt(updatePwReqDto.getNewpassword()));
    }

    @Override
    public String refreshAccessToken(String header) {
        //refresh token이 살아있는지 확인하고 accesstoken을 발급한다.
        String email = jwtProvider.extractEmail(header);
        String redisToken = redisUtil.getRefreshTokens(email);
        if(redisToken==null || redisToken.isEmpty() || redisUtil.isMatchToken(email, header)){
            new BadRequestException(ErrorCode.NOT_VALID_REFRESH_TOKEN);
        }
        //이제 검증 완료! 그럼 새로 acceestoken발급 시작!
        TokenDto accessToken = jwtProvider.createAccessToken(email);
//        TokenDto refreshToken = jwtProvider.createRefreshToken(email);

        //refreshtoken redis저장 및 갱신
//        redisUtil.saveRefreshToken();

        return accessToken.getToken();
    }


    @Override
    public Owners findByEmail(String email) {
        return ownersRepository.findByEmail(email).orElseThrow(() -> new BadRequestException(ErrorCode.NOT_EXISTS_OWNER));
    }

    @Override
    public Owners findByToken(String requestHeader) {
        return jwtProvider.extractUser(requestHeader);
    }

    @Override
    public void unRegister(SignInReqDto signInReqDto) {
        Owners owner = ownersRepository.findByEmail(signInReqDto.getEmail()).orElseThrow(() -> new BadRequestException(ErrorCode.NOT_EXISTS_OWNER));
        if(!encrypt.isMatch(signInReqDto.getPassword(),owner.getPassword())){
            ownersRepository.deleteByEmail(owner.getEmail());
        } else {
            throw new BadRequestException(ErrorCode.USER_NOT_MATCH);
        }
    }

    @Override
    public void deletedOwner(String email) {
        ownersRepository.deleteByEmail(email);
    }

}
