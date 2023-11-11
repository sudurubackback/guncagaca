package com.sudurukbackx6.adminservice.domain.owner.service;

import com.sudurukbackx6.adminservice.domain.owner.dto.request.BusinessValidReqDto;
import com.sudurukbackx6.adminservice.domain.owner.entity.Business;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.net.URISyntaxException;

public interface BusinessService {

    long checkBusinessValidation(BusinessValidReqDto reqDto, MultipartFile multipartFile) throws URISyntaxException, IOException;
    Business getBusinessById(Long businessId);
}
