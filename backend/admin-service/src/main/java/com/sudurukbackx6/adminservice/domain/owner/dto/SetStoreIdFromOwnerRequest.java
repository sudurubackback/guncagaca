package com.sudurukbackx6.adminservice.domain.owner.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SetStoreIdFromOwnerRequest {

    private String email;
    private Long storeId;
}
