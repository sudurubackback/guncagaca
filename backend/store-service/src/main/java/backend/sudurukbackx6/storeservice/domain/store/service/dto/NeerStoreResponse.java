package backend.sudurukbackx6.storeservice.domain.store.service.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Builder
@Getter
public class NeerStoreResponse {

    private Double distance;
    private Double latitude;
    private Double longitude;
    private StoreResponse store;

    public NeerStoreResponse(Double latitude, Double longitude, Double distance, StoreResponse store) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.distance = distance;
        this.store = store;
    }
}
