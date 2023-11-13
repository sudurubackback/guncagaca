package com.sudurukbackx6.adminservice.common.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@Builder
public class SignupEvent {
    private Long ownerId;
    private String email;
    private String password;
    private String tel;
    private Long storeId;
    private String ip;
    private String ddns;

    public SignupEvent(Long ownerId, String email, String password, String tel, Long storeId, String ip, String ddns) {
        this.ownerId = ownerId;
        this.email = email;
        this.password = password;
        this.tel = tel;
        this.storeId = storeId;
        this.ip = ip;
        this.ddns = ddns;
    }
}
