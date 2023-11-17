package com.sudurukbackx6.adminservice.domain.owner.dto.response;

import com.sudurukbackx6.adminservice.domain.owner.entity.Owners;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class SignResponseDto {
    /*
        1. accessToken, refreshToken
        2. isApproved
        3. ddns, ip, port, tel
     */
    public String accessToken;
    public String refreshToken;
    private boolean isApproved;
    private boolean isSetNetwork;
    @Builder
    public SignResponseDto(String accessToken, String refreshToken, Owners owner) {
        this.accessToken = accessToken;
        this.refreshToken = refreshToken;
        this.isApproved= owner.getStore() != null;
        this.isSetNetwork = owner.getIp() != null  /*&& owner.getDdns() != null*/ && owner.getPort() != null;
    }
}
