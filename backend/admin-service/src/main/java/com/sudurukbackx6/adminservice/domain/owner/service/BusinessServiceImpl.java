package com.sudurukbackx6.adminservice.domain.owner.service;

import com.sudurukbackx6.adminservice.domain.owner.dto.request.BusinessValidReqDto;
import com.sudurukbackx6.adminservice.domain.owner.entity.Business;
import com.sudurukbackx6.adminservice.domain.owner.repository.BusinessRepository;
import com.sudurukbackx6.adminservice.openApi.service.VendorService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.net.URISyntaxException;

@Service("BusinessService")
@Transactional
@RequiredArgsConstructor
@Slf4j
public class BusinessServiceImpl implements BusinessService {

    private final VendorService vendorService;
    private final BusinessRepository businessRepository;

    @Override
    public long checkBusinessValidation(BusinessValidReqDto reqDto) throws URISyntaxException {
        int isValidate = vendorService.checkVendorValidation(reqDto);
        log.info("isValidate : {}", isValidate);

        if (isValidate == 1) {
            //사업자 등록이 되어있는지 확인

            Business business = new Business(reqDto);
            Business saved= businessRepository.save(business);
            return saved.getBusinessId();

        }
        return -1;
    }

    @Override
    public Business getBusinessById(Long businessId) {
        return businessRepository.findById(businessId).orElseThrow(() -> new IllegalArgumentException("Business not found"));
    }


}



