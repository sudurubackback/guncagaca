package com.sudurukbackx6.adminservice.domain.owner.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.sudurukbackx6.adminservice.domain.owner.dto.request.NetworkReqDto;
import com.sudurukbackx6.adminservice.domain.owner.dto.request.OwnerSignInReqDto;
import com.sudurukbackx6.adminservice.domain.owner.dto.request.OwnerSignUpReqDto;
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

    // 네트워크(ip, ddns) 설정
    void setNetwork(String email, NetworkReqDto networkReqDto);

    // kafka 동기화
    void synchronizeServer(String email) throws JsonProcessingException;

    //비밀번호 수정
    void updatePassword(String email, String password);

    //비밀번호 찾기
    void findPassword(String email) throws MessagingException;

    boolean auth(String email, String password);
}
