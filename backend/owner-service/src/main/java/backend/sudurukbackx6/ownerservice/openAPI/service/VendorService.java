package backend.sudurukbackx6.ownerservice.openAPI.service;

import backend.sudurukbackx6.ownerservice.domain.business.dto.request.VendorVailidateReqDto;

import java.net.URISyntaxException;

public interface VendorService {
    int checkVendorValidation(VendorVailidateReqDto vendorVailidateReqDto) throws URISyntaxException;
}
