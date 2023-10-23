package backend.sudurukbackx6.ownerservice.domain.business.service;

import backend.sudurukbackx6.ownerservice.domain.business.dto.request.VendorVailidateReqDto;
import backend.sudurukbackx6.ownerservice.domain.business.entity.Business;
import backend.sudurukbackx6.ownerservice.domain.business.repository.BusinessRepository;
import backend.sudurukbackx6.ownerservice.domain.owner.entity.Owners;
import backend.sudurukbackx6.ownerservice.domain.owner.service.OwnerService;
import backend.sudurukbackx6.ownerservice.openAPI.service.VendorService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("BusinessService")
@Transactional
@RequiredArgsConstructor
@Slf4j
public class BusinessServiceImpl implements BusinessService{

    private final VendorService vendorService;
    private final BusinessRepository businessRepository;
    private final OwnerService ownerService;
    @Override
    public boolean checkBusinessValidation(VendorVailidateReqDto reqDto) {
        boolean isValidate =  vendorService.checkVendorValidation(reqDto);

        if(isValidate){
            Owners owner = ownerService.findByEmail(reqDto.getEmail());
            businessRepository.save(new Business(owner, reqDto));
        }else{
            ownerService.deletedOwner(reqDto.getEmail());
        }

        return isValidate;
    }
}
