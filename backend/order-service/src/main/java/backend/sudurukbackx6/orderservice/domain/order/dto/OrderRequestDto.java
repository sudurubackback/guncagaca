package backend.sudurukbackx6.orderservice.domain.order.dto;

import backend.sudurukbackx6.orderservice.domain.menu.entity.Menu;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
public class OrderRequestDto {

    private String receiptId;

    private Long storeId;

    private boolean takeoutYn;

    private int totalOrderPrice;

    private int eta;

    private List<Menu> menus;

}
