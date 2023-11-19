package com.sudurukbackx6.adminservice.domain.admin.service;

import com.sudurukbackx6.adminservice.domain.admin.dto.request.AdminSignInReqDto;
import com.sudurukbackx6.adminservice.domain.admin.dto.request.AdminSignUpReqDto;
import com.sudurukbackx6.adminservice.domain.admin.dto.response.AdminSignInResDto;
import com.sudurukbackx6.adminservice.domain.admin.dto.response.BusinessListResDto;
import com.sudurukbackx6.adminservice.domain.admin.dto.response.BusinessOneResDto;
import com.sudurukbackx6.adminservice.domain.owner.dto.request.ToggleApprovalRequestDto;
import com.sudurukbackx6.adminservice.domain.owner.entity.Business;

import java.util.List;

public interface AdminService {
    List<Business> getOwnerInfo(String email);
//    void toggleApproval(ToggleApprovalRequestDto toggleApprovalRequestDto);

    //1. 로그인
    AdminSignInResDto signIn(AdminSignInReqDto adminSignInReqDto);

    //2. 로그아웃
    void signOut(String email);

    //3. 가게 회원가입 신청 목록 조회, 전체
    List<BusinessListResDto> businessList();

    //4. 가게 회가입 신청 하나만 보기
    BusinessOneResDto getBusiness(Long businessId);

    //5. 가게 회원가입 승인
    void toggleApproval(Long OwnerId);

    List<BusinessListResDto> doneBusinessList();

    List<BusinessListResDto> waitingBusinessList();

    void signUp(AdminSignUpReqDto reqDto);
}
