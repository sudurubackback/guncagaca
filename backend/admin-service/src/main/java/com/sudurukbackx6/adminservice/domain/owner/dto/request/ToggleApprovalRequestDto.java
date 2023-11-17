package com.sudurukbackx6.adminservice.domain.owner.dto.request;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class ToggleApprovalRequestDto {
    private Long ownerId;
    private String email;
    private boolean validation;
}
