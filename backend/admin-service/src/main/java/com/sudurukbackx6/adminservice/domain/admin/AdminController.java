package com.sudurukbackx6.adminservice.domain.admin;

import com.sudurukbackx6.adminservice.common.dto.BaseResponseBody;
import com.sudurukbackx6.adminservice.domain.admin.dto.request.AdminSignInReqDto;
import com.sudurukbackx6.adminservice.domain.admin.dto.request.AdminSignUpReqDto;
import com.sudurukbackx6.adminservice.domain.admin.service.AdminService;
import com.sudurukbackx6.adminservice.domain.owner.entity.Business;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class AdminController {
    private final AdminService adminService;

    @PostMapping("/signup")
    public ResponseEntity<? extends BaseResponseBody> signUp(@RequestBody AdminSignUpReqDto requestDto) {
        adminService.signUp(requestDto);
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "회원가입 성공"));
    }

    @PostMapping("/signin")
    public ResponseEntity<? extends BaseResponseBody> signIn(@RequestBody AdminSignInReqDto requestDto) {
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "로그인 성공", adminService.signIn(requestDto)));
    }

    @GetMapping("/signout")
    public ResponseEntity<? extends BaseResponseBody> signOut(@RequestHeader("Email") String email) {
        adminService.signOut(email);
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "로그아웃 성공"));
    }

    @GetMapping("/info")
    public ResponseEntity<List<Business>> getOwnerInfo(@RequestHeader("Email") String email) {
        return ResponseEntity.ok(adminService.getOwnerInfo(email));
    }

    @PostMapping("/approval")
    public ResponseEntity<? extends BaseResponseBody> toggleApproval(@RequestBody Map<String, Long> map) {
        adminService.toggleApproval(map.get("owner_id"));
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "승인상태가 토글되었습니다."));
    }

    @GetMapping("/list")
    public ResponseEntity<? extends BaseResponseBody> businessList() {
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "조회성공", adminService.businessList()));
    }

    @GetMapping("/done-list")
    public ResponseEntity<? extends BaseResponseBody> approvedBusinessList() {
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "승인 완료 리스트", adminService.doneBusinessList()));
    }

    @GetMapping("/wait-list")
    public ResponseEntity<? extends BaseResponseBody> toDoBusinessList() {
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "승인 미완료 리스트", adminService.waitingBusinessList()));
    }

    @GetMapping("/list/{businessId}")
    public ResponseEntity<? extends BaseResponseBody> getBusiness(@PathVariable Long businessId) {
        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "조회성공", adminService.getBusiness(businessId)));
    }

}
