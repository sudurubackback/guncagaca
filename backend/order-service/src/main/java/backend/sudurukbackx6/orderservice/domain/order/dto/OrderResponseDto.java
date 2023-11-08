package backend.sudurukbackx6.orderservice.domain.order.dto;

import backend.sudurukbackx6.orderservice.domain.menu.entity.Menu;
import backend.sudurukbackx6.orderservice.domain.order.entity.Order;
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

    private Long memberId;

    private Long storeId;

    private int orderPrice;

    private List<Menu> menus;

    public OrderResponseDto(Long memberId, Long storeId, OrderRequestDto requestDto) {
        this.menus = requestDto.getMenus();
        this.orderPrice = requestDto.getTotalOrderPrice();
        this.memberId = memberId;
        this.storeId = storeId;
    }

//    public OrderResponseDto(Order order){
//        this.menus = order.getMenus();
//        this.orderPrice = order.getPrice();
////        this.memberId = order.getMemberId().toString();
////        this.storeId = order.getStoreId().toString();
//        this.memberId = order.getMemberId();
//        this.storeId = order.getStoreId();
//    }
}
