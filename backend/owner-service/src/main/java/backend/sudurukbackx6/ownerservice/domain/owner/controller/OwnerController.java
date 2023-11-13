package backend.sudurukbackx6.ownerservice.domain.owner.controller;

import backend.sudurukbackx6.ownerservice.common.dto.BaseResponseBody;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.ChangeOwnerStoreIdRequest;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.GetTodaySellingResponse;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.OwnerInfoResponse;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.request.SignInReqDto;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.request.SignUpReqDto;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.request.UpdatePwReqDto;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.response.SignInResDto;
import backend.sudurukbackx6.ownerservice.domain.owner.service.OwnerService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.mail.MessagingException;
import javax.ws.rs.Path;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/owner")
public class OwnerController {

    private final OwnerService ownerService;

    @Operation(summary = "회원가입", description = "email, password, tel, business_id을 활용해서 회원가입 진행 \n" +
            "/cert 을 한 후에 진행하도록 한다, 해당 api로 반환된 business_id 값을 넣어준다."+"\n")
    @PostMapping("/signup")
    public ResponseEntity<? extends BaseResponseBody> signUp(@RequestBody SignUpReqDto signUpReqDto) throws IOException, MessagingException {
        ownerService.signUp(signUpReqDto);
        return ResponseEntity.status(HttpStatus.CREATED).body(new BaseResponseBody<>(200, "회원가입 성공"));
    }

    @Operation(summary = "로그인", description = "로그인 \n\n")
    @PostMapping("/signin")
    public ResponseEntity<? extends BaseResponseBody> signin(@RequestBody SignInReqDto signInReqDto) throws IOException, InterruptedException {
        SignInResDto signInResDto = ownerService.signIn(signInReqDto);
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "로그인 성공", signInResDto));
    }

    @Operation(summary = "로그아웃", description = "로그아웃 \n\n")
    @PostMapping("/signout")
    public ResponseEntity<? extends BaseResponseBody> signout(@RequestHeader("Authorization") String header) throws IOException, InterruptedException {
        ownerService.signOut(header);
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "로그아웃 성공"));
    }

    @Operation(summary = "이메일로 인증 코드 전송", description = "이메일 인증로 인증 코드 전송\n\n")
    @PostMapping("/sendcode")
    public ResponseEntity<? extends BaseResponseBody> sendCode(@RequestBody Map<String, String> map) throws IOException, InterruptedException, MessagingException {
        String email = map.get("email");
        ownerService.sendAuthCode(email);
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "인증 코드 전송 성공"));
    }

    @Operation(summary = "유효한 이메일", description = "이메일의 양식확인 및 이메일이 데이터 베이스에 존재 하는지 확인\n\n")
    @PostMapping("/checkemail")
    public ResponseEntity<? extends BaseResponseBody> checkMail(@RequestBody Map<String, String> map) throws IOException, InterruptedException, MessagingException {
        String email = map.get("email");
        if (ownerService.checkValidEmail(email)) {
            return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "유효한 이메일"));
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new BaseResponseBody<>(400, "유효 하지 않은 이메일"));

    }

    @Operation(summary = "인증 코드 전송 확인", description = "이메일로 전송한 인증 코드와 일치 하는지 확인\n\n")
    @PostMapping("/checkcode")
    public ResponseEntity<? extends BaseResponseBody> checkCode(@RequestBody Map<String, String> map) throws IOException, InterruptedException, MessagingException {
        String email = map.get("email");
        String code = map.get("code");
        if (ownerService.checkAuthCode(email, code)) {
            return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "인증 코드 일치"));
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new BaseResponseBody<>(400, "인증 코드 불일치"));

    }

    @Operation(summary = "비밀번호 초기화", description = "이메일로 초기화된 비밀번호 전송\n\n")
    @PutMapping("/resetpw")
    public ResponseEntity<? extends BaseResponseBody> resetPw(@RequestBody Map<String, String> map) throws IOException, InterruptedException, MessagingException {
        String email = map.get("email");
        ownerService.resetPassword(email);
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "비밀번호 초기화 성공"));
    }


    @SecurityRequirement(name = "Authorization Header")
    @Operation(summary = "비밀번호 변경", description = "비밀번호 변경\n\n")
    @PutMapping("/changepw")
    public ResponseEntity<? extends BaseResponseBody> updatePw(@RequestHeader("Authorization") String token, @RequestBody UpdatePwReqDto updatePwReqDto) throws IOException, InterruptedException, MessagingException {
        ownerService.changePassword(token, updatePwReqDto);
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "비밀번호 변경 성공"));
    }


    @SecurityRequirement(name = "Authorization Header")
    @Operation(summary = "accesstoken 갱신", description = "refresh token을 사용해서 accasstoken 갱신\n\n")
    @PostMapping("/refresh")
    public ResponseEntity<? extends BaseResponseBody> refreshAccessToken(@RequestHeader("Authorization") String token) throws IOException, InterruptedException, MessagingException {

        Map<String, String> map = new HashMap<>();
        SignInResDto newAccessToken = ownerService.refreshAccessToken(token);

        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "accesstoken갱신 성공", newAccessToken));
    }

    @GetMapping("/ownerInfo")
    public ResponseEntity<OwnerInfoResponse> getOwnerInfo(@RequestHeader("Email") String email) {
        return ResponseEntity.ok(ownerService.ownerInfo(email));
    }

    @PutMapping("/ownersStore")
    public Long changeOwnersStoreId(@RequestBody ChangeOwnerStoreIdRequest request) {
        return ownerService.ownerStoreId(request);
    }
}
