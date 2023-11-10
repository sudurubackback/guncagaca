package backend.sudurukbackx6.storeservice.domain.store.service.dto;

import backend.sudurukbackx6.storeservice.domain.store.entity.Store;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
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
    private String address;

    public StoreResponse (Store store, boolean isLiked) {
        this.storeId = store.getId();
        this.cafeName = store.getName();
        this.starPoint = store.getStarPoint();
        this.reviewCount = store.getReview().size();
        this.img = store.getImg();
        this.address = store.getAddress();
        this.description = store.getDescription();
        this.openTime = store.getOpenTime();
        this.closeTime = store.getCloseTime();
        this.isOpen = store.isOpen();
        this.isLiked = isLiked;
    }
}
