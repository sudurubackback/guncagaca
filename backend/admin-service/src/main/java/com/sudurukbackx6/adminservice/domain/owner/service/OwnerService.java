package com.sudurukbackx6.adminservice.domain.owner.service;

import com.sudurukbackx6.adminservice.domain.owner.dto.SetStoreIdFromOwnerRequest;
import com.sudurukbackx6.adminservice.domain.owner.dto.request.OwnerSignInReqDto;
import com.sudurukbackx6.adminservice.domain.owner.dto.request.OwnerSignUpReqDto;
import com.sudurukbackx6.adminservice.domain.owner.dto.request.UpdatePwReqDto;
import com.sudurukbackx6.adminservice.domain.owner.dto.response.SignInResDto;
import com.sudurukbackx6.adminservice.domain.owner.dto.response.SignResponseDto;

import javax.mail.MessagingException;
import java.io.IOException;

public interface OwnerService {

    //1. 회원가입
    void signUp(OwnerSignUpReqDto signUpReqDto) throws IOException;

    //2. 로그인
    SignResponseDto signIn(OwnerSignInReqDto signInReqDto);

    //3. 로그아웃
    void deleteOwner(String header, String password);

    //4. 회원탈퇴
    void signOut(String header);

    // 이메일 중복 확인
    boolean checkValidEmail(String email);

    // 이메일 인증 코드 전송
    void sendAuthCode(String email) throws MessagingException;

    // 이메일 인증 코드 확인
    boolean checkAuthCode(String email, String code);

}
