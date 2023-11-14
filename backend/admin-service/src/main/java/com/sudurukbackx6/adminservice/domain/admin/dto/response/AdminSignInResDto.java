package com.sudurukbackx6.adminservice.domain.admin.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
@Builder
@AllArgsConstructor
public class AdminSignInResDto {
    private String refreshToken;
    private String accessToken;
}
