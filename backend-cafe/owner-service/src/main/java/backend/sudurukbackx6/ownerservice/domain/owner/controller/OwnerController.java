package backend.sudurukbackx6.ownerservice.domain.owner.controller;

import backend.sudurukbackx6.ownerservice.common.dto.BaseResponseBody;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.SetStoreIdFromOwnerRequest;
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
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/ceo")
public class OwnerController {

    private final OwnerService ownerService;

    @Operation(summary = "로그인", description = "로그인 \n\n")
    @PostMapping("/signin")
    public ResponseEntity<? extends BaseResponseBody> signin(@RequestBody SignInReqDto signInReqDto) throws IOException, InterruptedException {
        SignInResDto signInResDto = ownerService.signIn(signInReqDto);
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "로그인 성공", signInResDto));
    }

    @Operation(summary = "로그아웃", description = "로그아웃 \n\n")
    @PostMapping("/signout")
    public ResponseEntity<? extends BaseResponseBody> signout(@RequestHeader("Email") String email) throws IOException, InterruptedException {
        ownerService.signOut(email);
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "로그아웃 성공"));
    }

    @SecurityRequirement(name = "Authorization Header")
    @Operation(summary = "accesstoken 갱신", description = "refresh token을 사용해서 accasstoken 갱신\n\n")
    @PostMapping("/refresh")
    public ResponseEntity<? extends BaseResponseBody> refreshAccessToken(@RequestHeader("Authorization") String header) throws IOException, InterruptedException, MessagingException {

        Map<String, String> map = new HashMap<>();
        SignInResDto newAccessToken = ownerService.refreshAccessToken(header);

        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "accesstoken갱신 성공", newAccessToken));
    }

    @GetMapping("/ownerInfo")
    public ResponseEntity<OwnerInfoResponse> getOwnerInfo(@RequestHeader("Email") String email) {
        return ResponseEntity.ok(ownerService.ownerInfo(email));
    }

    @PutMapping("/ownersStore")
    public Long changeOwnersStoreId(@RequestBody SetStoreIdFromOwnerRequest request) {
        return ownerService.ownerStoreId(request);
    }
}
