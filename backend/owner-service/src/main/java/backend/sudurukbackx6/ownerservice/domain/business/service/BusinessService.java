package backend.sudurukbackx6.ownerservice.domain.business.service;

import backend.sudurukbackx6.ownerservice.domain.business.dto.request.VendorVailidateReqDto;

import java.net.URISyntaxException;

public interface BusinessService {

    boolean checkBusinessValidation(VendorVailidateReqDto reqDto) throws URISyntaxException;

}
