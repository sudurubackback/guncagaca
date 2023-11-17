package backend.sudurukbackx6.storeservice.domain.store.service.dto;

import backend.sudurukbackx6.storeservice.domain.store.entity.Store;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@Setter
@Getter
public class StoreRequest {
    private String storeName;
    private String address;
    private String tel;
    private String description;
    private String openTime;
    private String closeTime;

}
