package com.sudurukbackx6.adminservice.domain.admin.service;

import com.sudurukbackx6.adminservice.domain.admin.dto.request.SignInReqDto;


public interface AdminService {
    void toggleApproval(Long adminId);
//    TokenResDto signIn(SignInReqDto signInReqDto);
}
