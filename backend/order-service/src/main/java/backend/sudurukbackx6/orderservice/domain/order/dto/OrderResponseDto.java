package backend.sudurukbackx6.orderservice.domain.order.dto;

import backend.sudurukbackx6.orderservice.domain.menu.entity.Menu;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderResponseDto {

    private String memberId;

    private String storeId;

    private int orderPrice;

    private List<Menu> menus;

    public OrderResponseDto(String memberId, String storeId, OrderRequestDto requestDto) {
        this.menus = requestDto.getMenus();
        this.orderPrice = requestDto.getTotalOrderPrice();
        this.memberId = memberId;
        this.storeId = storeId;
    }
}
