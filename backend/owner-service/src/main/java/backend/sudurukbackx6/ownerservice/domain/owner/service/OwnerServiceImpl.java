package backend.sudurukbackx6.ownerservice.domain.owner.service;

import backend.sudurukbackx6.ownerservice.common.error.code.ErrorCode;
import backend.sudurukbackx6.ownerservice.common.error.exception.BadRequestException;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.request.SignInReqDto;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.request.SignUpReqDto;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.request.UpdatePwReqDto;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.response.SignInResDto;
import backend.sudurukbackx6.ownerservice.domain.owner.entity.Owners;
import backend.sudurukbackx6.ownerservice.domain.owner.repository.OwnersRepository;
import backend.sudurukbackx6.ownerservice.domain.token.config.JwtTokenProvider;
import backend.sudurukbackx6.ownerservice.domain.token.service.TokenService;
import backend.sudurukbackx6.ownerservice.mail.service.MailSenderService;
import backend.sudurukbackx6.ownerservice.redis.util.RedisUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestHeader;

import javax.mail.MessagingException;
import java.io.IOException;
import java.util.Optional;

@Service("OwnerService")
@Transactional
@RequiredArgsConstructor
@Slf4j
public class OwnerServiceImpl implements OwnerService {

    private final OwnersRepository ownersRepository;
    private final PasswordEncoder passwordEncoder;
    public final MailSenderService mailSenderService;
    private final JwtTokenProvider tokenProvider;

    @Override
    public void signUp(SignUpReqDto signUpReqDto) throws IOException {
        //해당 이메일이 먼저 존재하는지 확인
        Optional<Owners> exitOwner = ownersRepository.findByEmail(signUpReqDto.getEmail());

        if (exitOwner.isEmpty()) {
            //이미 가입된 회원이 없으면? 회원가입 진행한다.
            Owners owner = new Owners(signUpReqDto.getEmail(), passwordEncoder.encode(signUpReqDto.getPassword()), signUpReqDto.getTel());
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
    public boolean signIn(String email, String password) {
        Owners owner = ownersRepository.findByEmail(email).orElseThrow(() -> new BadRequestException(ErrorCode.NOT_EXISTS_OWNER));
        return passwordEncoder.matches(password, owner.getPassword());
    }


    @Override
    public void resetPassword(String email) throws MessagingException {
        Optional<Owners> ownerOptional = ownersRepository.findByEmail(email);
        Owners owner = ownerOptional.orElseThrow(() -> new BadRequestException(ErrorCode.NOT_EXISTS_OWNER));
        String newPassword = mailSenderService.sendPassword(email);
        owner.changePassword(passwordEncoder.encode(newPassword));
    }

    @Override
    public void changePassword(String token, UpdatePwReqDto updatePwReqDto) {
        Owners owner = findByToken(token);
        if (!passwordEncoder.matches(updatePwReqDto.getPassword(), owner.getPassword())) {
            throw new BadRequestException(ErrorCode.USER_NOT_MATCH);
        }
        owner.changePassword(passwordEncoder.encode(updatePwReqDto.getNewpassword()));
    }



    @Override
    public Owners findByEmail(String email) {
        return ownersRepository.findByEmail(email).orElseThrow(() -> new BadRequestException(ErrorCode.NOT_EXISTS_OWNER));
    }

    @Override
    public Owners findByToken(String requestHeader) {
        String parsedToken = requestHeader.substring("Bearer ".length()).trim();
        String email = tokenProvider.getUserEmail(parsedToken);
        return findByEmail(email);
    }

    @Override
    public void unRegister(SignInReqDto signInReqDto) {
        Owners owner = ownersRepository.findByEmail(signInReqDto.getEmail()).orElseThrow(() -> new BadRequestException(ErrorCode.NOT_EXISTS_OWNER));
        if (passwordEncoder.matches(signInReqDto.getPassword(), owner.getPassword())) {
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
