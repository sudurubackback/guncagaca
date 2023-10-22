package backend.sudurukbackx6.storeservice.domain.store.service.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
public class StoreResponse {
    private String cafeName;
    private Double starTotal;
    private int reviewCount;
    private String img;
}
