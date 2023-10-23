package backend.sudurukbackx6.ownerservice.openAPI.service;

import backend.sudurukbackx6.ownerservice.domain.business.dto.request.VendorVailidateReqDto;

public interface VendorService {
    boolean checkVendorValidation(VendorVailidateReqDto vendorVailidateReqDto);
}
