package com.sudurukbackx6.adminservice.domain.admin.dto.request;

import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public class AdminSignUpReqDto {
    String email;
    String name;
    String password;
}
