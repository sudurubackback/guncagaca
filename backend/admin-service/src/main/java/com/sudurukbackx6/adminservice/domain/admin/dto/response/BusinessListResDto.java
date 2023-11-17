package com.sudurukbackx6.adminservice.domain.admin.dto.response;

import com.sudurukbackx6.adminservice.domain.owner.entity.Business;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
public class BusinessListResDto {
    private final long business_id;    //PK값
    private final String business_name;
    private final String business_number;
    private final String owner_name;
    private final boolean isApproval;

    public BusinessListResDto(Business business){
        this.business_id = business.getBusinessId();
        this.business_name = business.getBusinessName();
        this.business_number = business.getBusinessNum();
        this.owner_name = business.getName();
        this.isApproval = business.isApproval();
    }
}
