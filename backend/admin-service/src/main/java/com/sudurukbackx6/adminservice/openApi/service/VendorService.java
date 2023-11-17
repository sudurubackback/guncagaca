package com.sudurukbackx6.adminservice.openApi.service;


import com.sudurukbackx6.adminservice.domain.owner.dto.request.BusinessValidReqDto;

import java.net.URISyntaxException;

public interface VendorService {
    int checkVendorValidation(BusinessValidReqDto vendorVailidateReqDto) throws URISyntaxException;
}
