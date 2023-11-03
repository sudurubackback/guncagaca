package backend.sudurukbackx6.ownerservice.domain.owner.service;

import backend.sudurukbackx6.ownerservice.domain.owner.dto.request.SignInReqDto;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.request.SignUpReqDto;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.request.UpdatePwReqDto;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.response.SignInResDto;
import backend.sudurukbackx6.ownerservice.domain.owner.entity.Owners;
import org.springframework.web.bind.annotation.RequestHeader;

import javax.mail.MessagingException;
import java.io.IOException;

public interface OwnerService {

    //1. 회원가입
    void signUp(SignUpReqDto signUpReqDto) throws IOException, MessagingException;

    //2. 이메일로 인증 코드 전송
    void sendAuthCode(String email) throws MessagingException;

    //3. 인증 코드 확인
    boolean checkAuthCode(String email, String code);

    //4. 이메일 중복 확인
    boolean checkValidEmail(String email);

    //5. 로그인 & 로그아웃
    SignInResDto signIn(SignInReqDto request);
    void signOut(String header);

    //6. 비밀번호 초기화, 이메일로 초기화된 비밀번호 전송
    void resetPassword(String email) throws MessagingException;

    //7. 비밀번호 변경
    void changePassword(String token, UpdatePwReqDto updatePwReqDto);

    //8. accesstoen 갱신
    SignInResDto refreshAccessToken(String header);

    Owners findByEmail(String email);

    Owners findByToken(String requestHeader);

    void unRegister(SignInReqDto signInReqDto);

    void deletedOwner(String email);

//    void toggleValidStatus(String email);
}
