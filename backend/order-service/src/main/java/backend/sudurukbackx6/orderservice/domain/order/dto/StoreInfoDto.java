package backend.sudurukbackx6.orderservice.domain.order.dto;

import lombok.Getter;

@Getter
public class StoreInfoDto {
    private Long storeId;
    private String cafeName;
    private Double starPoint;
    private int reviewCount;
    private String img;
    private String description;
    private String openTime;
    private String closeTime;
    private String address;
    private boolean isOpen;
    private boolean isLiked;
}
