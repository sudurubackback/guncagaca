package com.sudurukbackx6.adminservice.domain.admin.dto.response;


import com.sudurukbackx6.adminservice.domain.owner.entity.Business;
import lombok.Getter;

import java.time.LocalDate;

@Getter
public class BusinessOneResDto {
    private final long business_id;    //PK값
    private final String business_name;
    private final String business_number;
    private final String owner_name;
    private final boolean isApproval;
    private final String img; //이미지
    private final String address; //주소
    private final LocalDate open_date; //개업일
    private final long owner_id; //사장님 id
    private final String account_number; //계좌번호

    public BusinessOneResDto(Business business, long ownerId) {
        this.business_id = business.getBusinessId();
        this.business_name = business.getBusinessName();
        this.business_number = business.getBusinessNum();
        this.owner_name = business.getName();
        this.isApproval = business.isApproval();
        this.img = business.getImg();
        this.address = business.getAddress();
        this.open_date = business.getOpenDate();
        this.owner_id = ownerId;
        this.account_number = business.getAccountNum();
    }

}
