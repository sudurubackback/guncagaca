package backend.sudurukbackx6.storeservice.domain.store.service.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
public class NeerStoreResponse {

    private Long storeId;
    private String cafeName;
    private Double latitude;
    private Double longitude;
    private Double starTotal;
    private int reviewCount;
    private String img;
    private Double distance;
    private String address;
    private boolean isOpen;
    private String openTime;
    private String closeTime;
}
