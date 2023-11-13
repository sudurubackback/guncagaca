package com.sudurukbackx6.adminservice.domain.owner.service;

import com.sudurukbackx6.adminservice.common.code.ErrorCode;
import com.sudurukbackx6.adminservice.common.exception.BadRequestException;
import com.sudurukbackx6.adminservice.domain.owner.dto.request.ToggleApprovalRequestDto;
import com.sudurukbackx6.adminservice.domain.owner.entity.Business;
import com.sudurukbackx6.adminservice.domain.owner.entity.Owners;
import com.sudurukbackx6.adminservice.domain.owner.entity.Role;
import com.sudurukbackx6.adminservice.domain.owner.repository.BusinessRepository;
import com.sudurukbackx6.adminservice.domain.owner.repository.OwnersRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class AdminService {
    private final OwnersRepository ownersRepository;
    private final BusinessRepository businessRepository;

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
}
