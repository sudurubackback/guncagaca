package backend.sudurukbackx6.orderservice.domain.order.dto;

import backend.sudurukbackx6.orderservice.domain.order.entity.Menu;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
public class OrderRequestDto {
    private String memberId;

    private String storeId;

    private List<Menu> menus;
}
