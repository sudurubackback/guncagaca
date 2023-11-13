package com.sudurukbackx6.adminservice.common.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@Builder
public class StoreSaveEvent {
    private Long storeId;
    private String storeName;
    private String address;
    private String tel;
    private String description;
    private String openTime;
    private String closeTime;
    private Double latitude;
    private Double longitude;
    private String storeImg; // admin에서 저장한 S3 URL
}
