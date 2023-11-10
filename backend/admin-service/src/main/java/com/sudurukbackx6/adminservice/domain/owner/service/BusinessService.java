package com.sudurukbackx6.adminservice.domain.owner.service;

import com.sudurukbackx6.adminservice.domain.owner.dto.request.BusinessValidReqDto;
import com.sudurukbackx6.adminservice.domain.owner.entity.Business;

import java.net.URISyntaxException;

public interface BusinessService {

    long checkBusinessValidation(BusinessValidReqDto reqDto) throws URISyntaxException;
    Business getBusinessById(Long businessId);
}
