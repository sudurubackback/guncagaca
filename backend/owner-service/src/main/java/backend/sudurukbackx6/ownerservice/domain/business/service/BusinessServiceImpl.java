package backend.sudurukbackx6.ownerservice.domain.business.service;

import backend.sudurukbackx6.ownerservice.domain.business.dto.request.VendorValidateReqDto;
import backend.sudurukbackx6.ownerservice.domain.business.entity.Business;
import backend.sudurukbackx6.ownerservice.domain.business.repository.BusinessRepository;
import backend.sudurukbackx6.ownerservice.openAPI.service.VendorService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.net.URISyntaxException;

@Service("BusinessService")
@Transactional
@RequiredArgsConstructor
@Slf4j
public class BusinessServiceImpl implements BusinessService {

    private final VendorService vendorService;
    private final BusinessRepository businessRepository;

    @Override
    public long checkBusinessValidation(VendorValidateReqDto reqDto) throws URISyntaxException {
        int isValidate = vendorService.checkVendorValidation(reqDto);

        if (isValidate == 1) {
            //사업자 등록이 되어있는지 확인
            
            //사업자 등록이 되어 있으면 시작~! 우리가 확인하는 DB에 저장
            Business business = new Business(reqDto);
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



