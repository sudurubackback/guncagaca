package backend.sudurukbackx6.ownerservice.openAPI.service;

import backend.sudurukbackx6.ownerservice.domain.business.dto.request.VendorValidateReqDto;

import java.net.URISyntaxException;

public interface VendorService {
    int checkVendorValidation(VendorValidateReqDto vendorVailidateReqDto) throws URISyntaxException;
}
