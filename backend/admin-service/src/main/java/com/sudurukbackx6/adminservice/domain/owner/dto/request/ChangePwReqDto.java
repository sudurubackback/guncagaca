package com.sudurukbackx6.adminservice.domain.owner.dto.request;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class ChangePwReqDto {
    private String password;
    private String newPassword;
}
