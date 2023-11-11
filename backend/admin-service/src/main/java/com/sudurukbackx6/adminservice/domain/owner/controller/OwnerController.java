package com.sudurukbackx6.adminservice.domain.owner.controller;

import com.sudurukbackx6.adminservice.common.dto.BaseResponseBody;
import com.sudurukbackx6.adminservice.domain.owner.dto.SetStoreIdFromOwnerRequest;
import com.sudurukbackx6.adminservice.domain.owner.dto.request.OwnerSignInReqDto;
import com.sudurukbackx6.adminservice.domain.owner.dto.request.OwnerSignUpReqDto;
import com.sudurukbackx6.adminservice.domain.owner.service.OwnerService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.mail.MessagingException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;


@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/ceo")
public class OwnerController {

    private final OwnerService ownerService;

    //1. 회원가입
    @PostMapping("/signup")
    public ResponseEntity<? extends BaseResponseBody> signUp(OwnerSignUpReqDto signUpReqDto) throws IOException {
        ownerService.signUp(signUpReqDto);
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "회원가입 성공"));
    }
    //2. 로그인
    @PostMapping("/signin")
    public ResponseEntity<? extends BaseResponseBody> signIn(OwnerSignInReqDto signinInfo) throws IOException {

        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "로그인 성공", ownerService.signIn(signinInfo)));
    }
    //3. 로그아웃
    @PostMapping("/signout")
    public ResponseEntity<? extends BaseResponseBody> signOut(@RequestHeader("Email") String email) throws IOException {

        ownerService.signOut(email);
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "로그아웃 성공"));
    }

    //4. 회원탈퇴
    @PostMapping("/unRegist")
    public ResponseEntity<? extends BaseResponseBody> unRegist(@RequestHeader("Email") String email, @RequestBody Map<String, String> map) throws IOException {
        if(map.get("password")==null)
            throw new IOException("비밀번호를 입력해주세요");
        ownerService.deleteOwner(email, map.get("password"));
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "회원탈퇴 성공"));
    }

    // 이메일 중복 확인
    @PostMapping("/checkemail")
    public ResponseEntity<? extends BaseResponseBody> checkMail(@RequestBody Map<String, String> map) throws IOException, InterruptedException, MessagingException {
        String email = map.get("email");
        if (ownerService.checkValidEmail(email)) {
            return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "유효한 이메일"));
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new BaseResponseBody<>(400, "유효 하지 않은 이메일"));
    }
}
