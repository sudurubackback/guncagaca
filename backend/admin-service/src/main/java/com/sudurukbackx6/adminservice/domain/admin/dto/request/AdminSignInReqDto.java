package com.sudurukbackx6.adminservice.domain.admin.dto.request;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Negative;

@NoArgsConstructor
@Getter
public class AdminSignInReqDto {
    private String email;
    private String password;
}
