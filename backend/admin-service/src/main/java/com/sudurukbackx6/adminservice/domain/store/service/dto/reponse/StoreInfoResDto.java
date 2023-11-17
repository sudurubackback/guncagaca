package com.sudurukbackx6.adminservice.domain.store.service.dto.reponse;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class StoreInfoResDto {

    //1. 이미지 -  store
    //2. 설명 - store
    //3. 오픈시간 - store
    //4. 마감 시간 - store
    //5. 전화번호 - owner

    private String img;
    private String description;
    private String openTime;
    private String closeTime;
    private String tel;

}
