package com.sudurukbackx6.adminservice.domain.owner.dto.request;

import lombok.*;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OwnerSignUpReqDto {
    String email;
    String password;
    String tel;
    Long business_id;
}
