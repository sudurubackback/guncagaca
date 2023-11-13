package com.sudurukbackx6.adminservice.common.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class SignupEvent {
    String email;
    String password;
    String tel;
    Long business_id;
}
