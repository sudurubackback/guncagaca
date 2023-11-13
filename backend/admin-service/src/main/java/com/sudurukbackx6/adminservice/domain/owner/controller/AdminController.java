package com.sudurukbackx6.adminservice.domain.owner.controller;

import com.sudurukbackx6.adminservice.domain.owner.entity.Business;
import com.sudurukbackx6.adminservice.domain.owner.service.AdminService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class AdminController {
    private final AdminService adminService;

    @GetMapping("/info")

    public ResponseEntity<List<Business>> getOwnerInfo(@RequestHeader("Email") String email) {
        return ResponseEntity.ok(adminService.getOwnerInfo(email));
    }


//    @PostMapping("/approval")
//    public ResponseEntity<String> toggleApproval(@RequestBody Map<String, Long> requestBody) {
//        Long adminId = requestBody.get("adminId");
////        adminService.toggleApproval(adminId);
//        return ResponseEntity.ok("Approval 상태가 토글되었습니다.");
//    }
}
