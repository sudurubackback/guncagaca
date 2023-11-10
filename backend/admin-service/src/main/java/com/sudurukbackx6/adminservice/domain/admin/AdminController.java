package com.sudurukbackx6.adminservice.domain.admin;

import com.sudurukbackx6.adminservice.domain.admin.dto.request.SignInReqDto;
import com.sudurukbackx6.adminservice.domain.admin.service.AdminService;
import com.sudurukbackx6.adminservice.common.dto.BaseResponseBody;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/admin")
public class AdminController {

    private final AdminService adminService;

//    @PostMapping("/signin")
//    public ResponseEntity<? extends BaseResponseBody> signIn(@RequestBody SignInReqDto signInReqDto) {
//        return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "로그인 성공", adminService.signIn(signInReqDto)));
//    }

    @PostMapping("/toggle-approval")
    public ResponseEntity<String> toggleApproval(@RequestBody Map<String, Long> requestBody) {
        Long adminId = requestBody.get("adminId");
        adminService.toggleApproval(adminId);
        return ResponseEntity.ok("Approval 상태가 토글되었습니다.");


    }
}
