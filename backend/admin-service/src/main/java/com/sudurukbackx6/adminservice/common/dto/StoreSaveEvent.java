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

    public StoreSaveEvent(Long storeId, String storeName, String address, String tel, String description, String openTime, String closeTime, Double latitude, Double longitude, String storeImg) {
        this.storeId = storeId;
        this.storeName = storeName;
        this.address = address;
        this.tel = tel;
        this.description = description;
        this.openTime = openTime;
        this.closeTime = closeTime;
        this.latitude = latitude;
        this.longitude = longitude;
        this.storeImg = storeImg;
    }
}
