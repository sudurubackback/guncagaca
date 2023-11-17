package backend.sudurukbackx6.ownerservice.domain.order.dto;

import backend.sudurukbackx6.ownerservice.domain.menu.entity.enumTypes.Status;
import backend.sudurukbackx6.ownerservice.domain.order.entity.Menu;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Builder
public class StoreOrderResponse {

    private Long memberId;
    private LocalDateTime orderTime;
    private Status status;
    private Boolean takeoutYn;
    private List<Menu> menuList;
    private int price;
}
