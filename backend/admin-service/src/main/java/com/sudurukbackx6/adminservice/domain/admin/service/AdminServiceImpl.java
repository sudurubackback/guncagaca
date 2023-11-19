package com.sudurukbackx6.adminservice.domain.admin.service;

import com.sudurukbackx6.adminservice.common.code.ErrorCode;
import com.sudurukbackx6.adminservice.common.exception.BadRequestException;
import com.sudurukbackx6.adminservice.domain.admin.dto.request.AdminSignInReqDto;
import com.sudurukbackx6.adminservice.domain.admin.dto.request.AdminSignUpReqDto;
import com.sudurukbackx6.adminservice.domain.admin.dto.response.AdminSignInResDto;
import com.sudurukbackx6.adminservice.domain.admin.dto.response.BusinessListResDto;
import com.sudurukbackx6.adminservice.domain.admin.dto.response.BusinessOneResDto;
import com.sudurukbackx6.adminservice.domain.admin.entity.Admin;
import com.sudurukbackx6.adminservice.domain.admin.repository.AdminRepository;
import com.sudurukbackx6.adminservice.domain.owner.dto.request.ToggleApprovalRequestDto;
import com.sudurukbackx6.adminservice.domain.owner.entity.Business;
import com.sudurukbackx6.adminservice.domain.owner.entity.Owners;
import com.sudurukbackx6.adminservice.domain.owner.entity.Role;
import com.sudurukbackx6.adminservice.domain.owner.repository.BusinessRepository;
import com.sudurukbackx6.adminservice.domain.owner.repository.OwnersRepository;
import com.sudurukbackx6.adminservice.domain.store.service.StoreService;
import com.sudurukbackx6.adminservice.jwt.JwtProvider;
import com.sudurukbackx6.adminservice.jwt.TokenDto;
import com.sudurukbackx6.adminservice.redis.util.RedisUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service("AdminService")
@Transactional
@RequiredArgsConstructor
@Slf4j
public class AdminServiceImpl implements AdminService {

    private final OwnersRepository ownersRepository;
    private final BusinessRepository businessRepository;
    private final AdminRepository adminRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtProvider jwtProvider;
    private final RedisUtil redisUtil;
    private final StoreService storeService;

    public List<Business> getOwnerInfo(String email) {
        Owners owners = ownersRepository.findByEmail(email)
                .orElseThrow(() -> new BadRequestException(ErrorCode.NOT_EXISTS_EMAIL));

        if (!owners.getRole().equals(Role.ADMIN)) {
            throw new BadRequestException(ErrorCode.NOT_EXISTS_ADMIN);
        }

        return businessRepository.findAll();
    }

    public void toggleApproval(ToggleApprovalRequestDto toggleApprovalRequestDto) {
        Owners owner = ownersRepository.findByEmail(toggleApprovalRequestDto.getEmail())
                .orElseThrow(() -> new BadRequestException(ErrorCode.NOT_EXISTS_EMAIL));

        owner.changeValidation();
    }

    @Override
    public AdminSignInResDto signIn(AdminSignInReqDto adminSignInReqDto) {
        Admin admin = adminRepository.findByEmail(adminSignInReqDto.getEmail())
                .orElseThrow(() -> new BadRequestException(ErrorCode.NOT_EXISTS_EMAIL));

        if (!passwordEncoder.matches(adminSignInReqDto.getPassword(), admin.getPassword())) {
            throw new BadRequestException(ErrorCode.NOT_MATCH);
        }

        TokenDto accessToken = jwtProvider.createAccessToken(admin.getName(), admin.getEmail());
        TokenDto refreshToken = jwtProvider.createRefreshToken(admin.getName(), admin.getEmail());

        redisUtil.saveRefreshToken(admin.getEmail(), refreshToken.getToken());

        return AdminSignInResDto.builder()
                .accessToken(accessToken.getToken())
                .refreshToken(refreshToken.getToken())
                .build();

    }

    @Override
    public void signOut(String email) {
        redisUtil.deleteRefreshToken(email);
    }

    @Override
    public List<BusinessListResDto> businessList() {
        List<Business> businessList = businessRepository.findAll();
        return convertBusinessList(businessList);
    }

    @Override
    public BusinessOneResDto getBusiness(Long businessId) {
        Business business = businessRepository.findById(businessId)
                .orElseThrow(() -> new BadRequestException(ErrorCode.NOT_EXISTS_BUSINESS));

        Owners owner = ownersRepository.findByBusiness(business)
                .orElseThrow(() -> new BadRequestException(ErrorCode.NOT_EXISTS_OWNER));

        return new BusinessOneResDto(business, owner.getOwnerId());

    }

    @Override
    public void toggleApproval(Long ownerId) {


        Owners owner = ownersRepository.findById(ownerId)
                .orElseThrow(() -> new BadRequestException(ErrorCode.NOT_EXISTS_OWNER));

        Business business = businessRepository.findById(owner.getBusiness().getBusinessId())
                .orElseThrow(() -> new BadRequestException(ErrorCode.NOT_EXISTS_BUSINESS));

        owner.changeValidation();
        business.toggleApproval();
        
        //그리고 이제 store생성해서 저장 -> owner에 저장
        storeService.initStore(ownerId);
    }

    @Override
    public List<BusinessListResDto> doneBusinessList() {
        List<Business> businessList = businessRepository.findByApprovalTrue();
        return convertBusinessList(businessList);
    }

    @Override
    public List<BusinessListResDto> waitingBusinessList() {
        List<Business> businessList = businessRepository.findByApprovalFalse();

        return convertBusinessList(businessList);
    }

    @Override
    public void signUp(AdminSignUpReqDto reqDto) {
        Admin admin = Admin.builder()
                .email(reqDto.getEmail())
                .password(passwordEncoder.encode(reqDto.getPassword()))
                .name(reqDto.getName())
                .build();

        adminRepository.save(admin);
    }

    public List<BusinessListResDto> convertBusinessList(List<Business> businessList) {
        List<BusinessListResDto> list = new ArrayList<>();
        for (Business b : businessList) {
            if (b.getOwners() == null) {
//                businessRepository.delete(b);
                continue;
            }
            list.add(new BusinessListResDto(b));
        }

        return list;
    }


}
