package com.sudurukbackx6.adminservice.domain.store.service.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class StoreUpdateReqDto {
    private String tel;
    private String description;
    private String openTime;
    private String closeTime;
}
