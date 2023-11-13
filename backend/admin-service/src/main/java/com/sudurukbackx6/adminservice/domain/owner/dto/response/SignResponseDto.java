package com.sudurukbackx6.adminservice.domain.owner.dto.response;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class SignResponseDto {
    public String accessToken;
    public String refreshToken;
    private boolean isApproved;
    @Builder
    public SignResponseDto(String accessToken, String refreshToken, boolean isApproved) {
        this.accessToken = accessToken;
        this.refreshToken = refreshToken;
        this.isApproved = isApproved;
    }
}
