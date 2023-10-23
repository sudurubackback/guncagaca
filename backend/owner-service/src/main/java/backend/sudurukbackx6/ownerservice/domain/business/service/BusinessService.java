package backend.sudurukbackx6.ownerservice.domain.business.service;

import backend.sudurukbackx6.ownerservice.domain.business.dto.request.VendorVailidateReqDto;

public interface BusinessService {

    boolean checkBusinessValidation(VendorVailidateReqDto reqDto);
//    void saveBusiness(VendorVailidateReqDto reqDto);
}
