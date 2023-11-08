package backend.sudurukbackx6.orderservice.domain.order.dto.response;

import backend.sudurukbackx6.orderservice.domain.menu.entity.Menu;
import backend.sudurukbackx6.orderservice.domain.order.entity.Order;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;


@Getter
@NoArgsConstructor
public class OrderListResDto {
    private String orderId;
    private String receiptId;
    private Long memberId;

    private Long storeId;

    private int orderPrice;

    private List<Menu> menus;
    private boolean takeoutYn;
    private LocalDateTime orderTime;

    public OrderListResDto(Order order){
        this.orderId = order.getId();
        this.receiptId = order.getReceiptId();
        this.menus = order.getMenus();
        this.orderPrice = order.getPrice();
        this.memberId = order.getMemberId();
        this.storeId = order.getStoreId();
        this.takeoutYn = order.isTakeoutYn();
        this.orderTime = order.getOrderTime();
    }
}
