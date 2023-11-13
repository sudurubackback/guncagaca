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
    private String ddns;
    private String ip;
    private String port;
    private String tel;
    @Builder
    public SignResponseDto(String accessToken, String refreshToken, Owners owner) {
        this.accessToken = accessToken;
        this.refreshToken = refreshToken;
        this.isApproved= owner.getStore() != null;
        this.ddns = owner.getDdns();
        this.ip = owner.getIp();
        this.port = owner.getPort();
        this.tel = owner.getTel();
    }
}
