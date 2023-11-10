package com.sudurukbackx6.adminservice.domain.owner.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class OwnerSignInReqDto {
    String email;
    String password;
}
