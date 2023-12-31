package com.sudurukbackx6.adminservice.domain.owner.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.sudurukbackx6.adminservice.common.dto.BaseResponseBody;
import com.sudurukbackx6.adminservice.domain.owner.dto.request.ChangePwReqDto;
import com.sudurukbackx6.adminservice.domain.owner.dto.request.NetworkReqDto;
import com.sudurukbackx6.adminservice.domain.owner.dto.request.OwnerSignInReqDto;
import com.sudurukbackx6.adminservice.domain.owner.dto.request.OwnerSignUpReqDto;
import com.sudurukbackx6.adminservice.domain.owner.dto.response.OwnerIpListResponseDto;
import com.sudurukbackx6.adminservice.domain.owner.service.OwnerService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.mail.MessagingException;
import java.io.IOException;
import java.util.List;
import java.util.Map;


@Slf4j
@RequiredArgsConstructor
@CrossOrigin(origins = {"http://localhost:3000"})
@RestController
@RequestMapping("/api/ceo")
public class OwnerController {

    private final OwnerService ownerService;

    //1. 회원가입
    @PostMapping("/signup")
    public ResponseEntity<? extends BaseResponseBody> signUp(@RequestBody OwnerSignUpReqDto signUpReqDto) throws IOException {
        ownerService.signUp(signUpReqDto);
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "회원가입 성공"));
    }
    //2. 로그인
    @PostMapping("/signin")
    public ResponseEntity<? extends BaseResponseBody> signIn(@RequestBody  OwnerSignInReqDto signinInfo) throws IOException {

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

    // 이메일 인증코드 전송
    @PostMapping("/code")
    public ResponseEntity<? extends BaseResponseBody> sendCode(@RequestBody Map<String, String> map) throws IOException, InterruptedException, MessagingException {
        String email = map.get("email");
        ownerService.sendAuthCode(email);
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "인증 코드 전송 성공"));
    }

    // 이메일 인증코드 확인
    @PostMapping("/checkcode")
    public ResponseEntity<? extends BaseResponseBody> checkCode(@RequestBody Map<String, String> map) throws IOException, InterruptedException, MessagingException {
        String email = map.get("email");
        String code = map.get("code");
        if (ownerService.checkAuthCode(email, code)) {
            return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "인증 코드 일치"));
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new BaseResponseBody<>(400, "인증 코드 불일치"));

    }

    // ip, ddns 등록
    @PostMapping("/network")
    public ResponseEntity<? extends BaseResponseBody> setNetwork(@RequestHeader("Email") String email, @RequestBody NetworkReqDto networkReqDto) {
        ownerService.setNetwork(email, networkReqDto);
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "네트워크 설정 완료"));
    }

    @GetMapping("/network")
    public ResponseEntity<? extends BaseResponseBody> getNetwork(@RequestHeader("Email") String email) {
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "네트워크 설정 조회 성공", ownerService.getNetwork(email)));
    }

    // 서버 동기화
    @PostMapping("/sync")
    public ResponseEntity<? extends BaseResponseBody> synchronizeServer(@RequestHeader("Email") String email) throws JsonProcessingException {
        ownerService.synchronizeServer(email);
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "서버 동기화 완료"));
    }

    @PutMapping("/password")
    public ResponseEntity<? extends BaseResponseBody> updatePassword(@RequestHeader("Email") String email, @RequestBody ChangePwReqDto reqDto) throws IOException {

        ownerService.updatePassword(email, reqDto);
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "비밀번호 변경 완료"));
    }

    @PostMapping("/resetpassword")
    public ResponseEntity<? extends BaseResponseBody> resetPassword(@RequestBody Map<String, String> map) throws IOException, MessagingException {
        if(map.get("email")==null)
            throw new IOException("이메일을 입력해주세요");
        ownerService.findPassword(map.get("email"));
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "비밀번호를 이메일로 전송하였습니다."));
    }

    @PostMapping("/auth")
    public ResponseEntity<? extends BaseResponseBody> auth (@RequestHeader("Email") String email, @RequestBody Map<String, String> map) throws IOException {
        if(map.get("password")==null)
            throw new IOException("비밀번호를 입력해주세요");

        boolean flag = ownerService.auth(email, map.get("password"));

        if(!flag) return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new BaseResponseBody<>(400, "인증 실패"));
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "인증 성공"));
    }

    // 가게 ip 정보 가져오기
    @GetMapping("/ip")
    public ResponseEntity<List<OwnerIpListResponseDto>> getIpList (@RequestHeader("Email") String email){
        return ResponseEntity.ok(ownerService.getIpList(email));
    }

}
