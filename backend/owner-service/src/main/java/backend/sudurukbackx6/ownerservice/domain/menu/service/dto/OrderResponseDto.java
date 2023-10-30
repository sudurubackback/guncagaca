package backend.sudurukbackx6.ownerservice.domain.menu.service.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
@Builder
public class OrderResponseDto {
    private String memberId;

    private String storeId;

    private int orderPrice;

    private List<MenuResponseDto> menus;

    public OrderResponseDto(String memberId, String storeId, int orderPrice, List<MenuResponseDto> menus) {
        this.memberId = memberId;
        this.storeId = storeId;
        this.orderPrice = orderPrice;
        this.menus = menus;
    }
}
