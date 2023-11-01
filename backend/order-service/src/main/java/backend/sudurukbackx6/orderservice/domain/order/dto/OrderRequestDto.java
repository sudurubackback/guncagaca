package backend.sudurukbackx6.orderservice.domain.order.dto;

import backend.sudurukbackx6.orderservice.domain.menu.entity.Menu;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
public class OrderRequestDto {

    private Long memberId;

    private Long storeId;

    private boolean takeoutYn;

    private int totalOrderPrice;

    private List<Menu> menus;

    public OrderRequestDto(Long storeId, boolean takeoutYn, int totalOrderPrice, List<Menu> menus) {
        this.storeId = storeId;
        this.takeoutYn = takeoutYn;
        this.totalOrderPrice = totalOrderPrice;
        this.menus = menus;
    }
}
