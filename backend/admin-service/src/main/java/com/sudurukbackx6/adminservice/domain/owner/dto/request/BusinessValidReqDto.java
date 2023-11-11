package com.sudurukbackx6.adminservice.domain.owner.dto.request;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BusinessValidReqDto {

    //api에서 사용 하지는 않지만 필요한 정보
    private String business_name; //가게 이름
    private String address; //가게 주소

    //open api에서 사용하는 정보
    private String business_number; //사업자 번호
    private String owner_name;
    private String open_date;
    private String account_number;  //계좌번호
}
