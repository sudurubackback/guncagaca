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

    private Long storeId;
    private String cafeName;
    private Double starPoint;
    private int reviewCount;
    private String img;
    private boolean isLiked;
    private String description;
    private String openTime;
    private String closeTime;
    private boolean isOpen;
}
