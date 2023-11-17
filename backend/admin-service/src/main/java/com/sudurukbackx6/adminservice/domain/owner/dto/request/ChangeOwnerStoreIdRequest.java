package com.sudurukbackx6.adminservice.domain.owner.dto.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ChangeOwnerStoreIdRequest {

    private String email;
    private Long storeId;
}
