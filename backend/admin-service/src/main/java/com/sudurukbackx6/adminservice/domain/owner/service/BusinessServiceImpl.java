package com.sudurukbackx6.adminservice.domain.owner.service;

import com.sudurukbackx6.adminservice.domain.owner.dto.request.BusinessValidReqDto;
import com.sudurukbackx6.adminservice.domain.owner.entity.Business;
import com.sudurukbackx6.adminservice.domain.owner.repository.BusinessRepository;
import com.sudurukbackx6.adminservice.global.s3.S3Uploader;
import com.sudurukbackx6.adminservice.openApi.service.VendorService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.net.URISyntaxException;

@Service("BusinessService")
@Transactional
@RequiredArgsConstructor
@Slf4j
public class BusinessServiceImpl implements BusinessService {

    private final VendorService vendorService;
    private final BusinessRepository businessRepository;
    private final S3Uploader s3Uploader;

    @Override
    public long checkBusinessValidation(BusinessValidReqDto reqDto, MultipartFile multipartFile) throws URISyntaxException, IOException {
        int isValidate = vendorService.checkVendorValidation(reqDto);

        if (isValidate == 1) {
            //사업자 등록이 되어있는지 확인

            // 사업자 등록증 S3 업로드
            
            String uploadURL = s3Uploader.upload(multipartFile, reqDto.getBusiness_name());
            Business business = new Business(reqDto, uploadURL);
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



