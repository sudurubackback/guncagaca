package backend.sudurukbackx6.orderservice.domain.order.dto;

import backend.sudurukbackx6.orderservice.domain.menu.entity.Menu;
import backend.sudurukbackx6.orderservice.domain.order.entity.Status;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Builder
public class StoreOrderResponse {

    private Long memberId;
    private LocalDateTime orderTime;
    private String status;
    private Boolean takeoutYn;
    private List<Menu> menuList;
    private BigDecimal price;

}
