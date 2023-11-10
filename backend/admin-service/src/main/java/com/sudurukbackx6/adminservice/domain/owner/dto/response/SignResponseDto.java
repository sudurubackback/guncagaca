package com.sudurukbackx6.adminservice.domain.owner.dto.response;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class SignResponseDto {
    public String accessToken;
    public String refreshToken;

    @Builder
    public SignResponseDto(String accessToken, String refreshToken) {
        this.accessToken = accessToken;
        this.refreshToken = refreshToken;
    }
}
