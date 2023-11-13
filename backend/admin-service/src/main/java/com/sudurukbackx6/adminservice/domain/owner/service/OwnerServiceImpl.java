package com.sudurukbackx6.adminservice.domain.owner.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.sudurukbackx6.adminservice.common.code.ErrorCode;
import com.sudurukbackx6.adminservice.common.config.KafkaEventService;
import com.sudurukbackx6.adminservice.common.dto.SignupEvent;
import com.sudurukbackx6.adminservice.common.dto.StoreSaveEvent;
import com.sudurukbackx6.adminservice.common.exception.BadRequestException;
import com.sudurukbackx6.adminservice.domain.owner.dto.request.NetworkReqDto;
import com.sudurukbackx6.adminservice.domain.owner.dto.request.OwnerSignInReqDto;
import com.sudurukbackx6.adminservice.domain.owner.dto.request.OwnerSignUpReqDto;
import com.sudurukbackx6.adminservice.domain.owner.dto.response.SignResponseDto;
import com.sudurukbackx6.adminservice.domain.owner.entity.Business;
import com.sudurukbackx6.adminservice.domain.owner.entity.Owners;
import com.sudurukbackx6.adminservice.domain.owner.entity.Role;
import com.sudurukbackx6.adminservice.domain.owner.repository.OwnersRepository;
import com.sudurukbackx6.adminservice.domain.store.entity.Store;
import com.sudurukbackx6.adminservice.jwt.JwtProvider;
import com.sudurukbackx6.adminservice.jwt.TokenDto;
import com.sudurukbackx6.adminservice.mail.service.MailSenderService;
import com.sudurukbackx6.adminservice.redis.util.RedisUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
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
    private final JwtProvider jwtProvider;
    private final RedisUtil redisUtil;
    private final BusinessService businessService;
    private final PasswordEncoder passwordEncoder;
    private final MailSenderService mailSenderService;
    private final KafkaEventService kafkaEventService;


    @Override
    public void signUp(OwnerSignUpReqDto signUpReqDto) throws IOException {
        Optional<Owners> exitOwner = ownersRepository.findByEmail(signUpReqDto.getEmail());

        if (exitOwner.isEmpty()) {
            //이미 가입된 회원이 없으면? 회원가입 진행한다.
            Business business = businessService.getBusinessById(signUpReqDto.getBusiness_id());
            Owners owner = new Owners(signUpReqDto.getEmail(), passwordEncoder.encode(signUpReqDto.getPassword()), signUpReqDto.getTel(), business, Role.USER);
            ownersRepository.save(owner);
        } else {
            throw new BadRequestException(ErrorCode.DUPLICATED_EMAIL);  //중복된 이메일이라는 오류 뱉음
        }
    }

    @Override
    public SignResponseDto signIn(OwnerSignInReqDto signinInfo) {

        Owners owner = ownersRepository.findByEmail(signinInfo.getEmail()).orElseThrow(() -> new BadRequestException(ErrorCode.NOT_EXISTS_EMAIL));
        if (passwordEncoder.matches(signinInfo.getPassword(), owner.getPassword())) {

            TokenDto accessToken = jwtProvider.createAccessToken(owner.getBusiness().getName(), owner.getEmail());
            TokenDto refreshToken = jwtProvider.createRefreshToken(owner.getBusiness().getName(), owner.getEmail());

            redisUtil.saveRefreshToken(owner.getEmail(), refreshToken.getToken());

            if(owner.getStore()==null){
                return SignResponseDto.builder()
                        .accessToken(accessToken.getToken())
                        .refreshToken(refreshToken.getToken())
                        .isApproved(false)
                        .build();
            }
            return SignResponseDto.builder()
                    .accessToken(accessToken.getToken())
                    .refreshToken(refreshToken.getToken())
                    .build();
        } else {
            throw new BadRequestException(ErrorCode.NOT_MATCH);
        }
    }

    @Override
    public void deleteOwner(String email, String password) {
        //로그아웃, redis에서 해당 토큰을 지운다.
        Owners owner = ownersRepository.findByEmail(email).orElseThrow(() -> new BadRequestException(ErrorCode.NOT_EXISTS_EMAIL));
        if (passwordEncoder.matches(password,owner.getPassword())) {
            redisUtil.deleteRefreshToken(email);
        } else {
            throw new BadRequestException(ErrorCode.NOT_MATCH);
        }
    }

    @Override
    public void signOut(String email) {
        //회원탈퇴, redis에서 해당 토큰을 지우고, 회원정보를 지운다.
        redisUtil.deleteRefreshToken(email);
        ownersRepository.deleteByEmail(email);
    }

    @Override
    public boolean checkValidEmail(String email) {
        Optional<Owners> exitOwner = ownersRepository.findByEmail(email);

        if(exitOwner.isPresent()) return false;

        //존재 한다면 이메일 양식이 맞는지 확인
        return email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$");
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
    public void setNetwork(String email, NetworkReqDto networkReqDto) {
        Owners owner = ownersRepository.findByEmail(email)
                .orElseThrow(() -> new BadRequestException(ErrorCode.NOT_EXISTS_EMAIL));

        // 네트워크 설정
        owner.changeNetwork(networkReqDto.getIp(), networkReqDto.getDdns(), "8000");
    }

    @Override
    public void synchronizeServer(String email) throws JsonProcessingException {
        Owners owner = ownersRepository.findByEmail(email)
                .orElseThrow(() -> new BadRequestException(ErrorCode.NOT_EXISTS_EMAIL));
        Store store = owner.getStore();

        // 회원 정보 동기화
        SignupEvent signupEvent = SignupEvent.builder()
                .ownerId(owner.getOwnerId())
                .storeId(owner.getStore().getId())
                .email(owner.getEmail())
                .password(owner.getPassword())
                .tel(owner.getTel())
                .ip(owner.getIp())
                .ddns(owner.getDdns())
                .build();

        kafkaEventService.publishbySignup("adminOwner", signupEvent);

        // 가게 정보 동기화
        StoreSaveEvent saveEvent = StoreSaveEvent.builder()
                .storeId(store.getId())
                .address(store.getAddress())
                .tel(store.getTel())
                .description(store.getDescription())
                .openTime(store.getOpenTime())
                .closeTime(store.getCloseTime())
                .latitude(store.getLatitude())
                .longitude(store.getLongitude())
                .storeImg(store.getImg())
                .build();

        kafkaEventService.publishbyStoreSave("adminStore", saveEvent);

    }

}
