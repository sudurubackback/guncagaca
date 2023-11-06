package backend.sudurukbackx6.ownerservice.domain.business.service;

import backend.sudurukbackx6.ownerservice.domain.business.dto.request.VendorValidateReqDto;
import backend.sudurukbackx6.ownerservice.domain.business.entity.Business;

import java.net.URISyntaxException;

public interface BusinessService {

    long checkBusinessValidation(VendorValidateReqDto reqDto) throws URISyntaxException;
    Business getBusinessById(Long businessId);
}
