package com.sudurukbackx6.adminservice.domain.owner.dto.response;

import com.sudurukbackx6.adminservice.domain.owner.entity.Owners;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OwnerIpListResponseDto {
    private Long ownerId;
    private Long storeId;
    private String ip;
    private String port;

    public OwnerIpListResponseDto(Owners owners) {
        this.ownerId = owners.getOwnerId();
        this.storeId = owners.getStore().getId();
        this.ip = owners.getIp();
        this.port = owners.getPort();
    }
}
