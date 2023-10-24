package backend.sudurukbackx6.storeservice.domain.store.service.dto;

import backend.sudurukbackx6.storeservice.domain.store.entity.Store;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public class StoreRequest {
    private String storeName;
    private Double latitude;
    private Double longitude;
    private String address;
    private String tel;
    private String img;
    private String description;

}
