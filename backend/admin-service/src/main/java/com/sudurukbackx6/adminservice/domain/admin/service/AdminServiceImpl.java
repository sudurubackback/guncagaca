package com.sudurukbackx6.adminservice.domain.admin.service;

import com.sudurukbackx6.adminservice.domain.admin.entity.Admin;
import com.sudurukbackx6.adminservice.domain.admin.repository.AdminRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
@Service
public class AdminServiceImpl implements AdminService{

    private final AdminRepository adminRepository;


    @Override
    @Transactional
    public void toggleApproval(Long adminId) {
        Admin admin = adminRepository.findById(adminId)
                .orElseThrow(() -> new IllegalArgumentException("해당 ID의 Admin이 존재하지 않습니다."));
        admin.toggleApproval(); // approval 상태를 토글합니다.
    }

//    @Override
//    public TokenResDto signIn(SignInReqDto signInReqDto) {
//        if(!signInReqDto.getEmail().equals(adminProperties.getEmail()) || !signInReqDto.getPassword().equals(adminProperties.getPassword())){
//            throw new BadRequestException(ErrorCode.NOT_MATCH);
//        }
//        return tokenService.createToken(signInReqDto.getEmail());
//    }
}
