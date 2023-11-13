package backend.sudurukbackx6.storeservice.domain.store.service.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StoreSaveEvent {
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
