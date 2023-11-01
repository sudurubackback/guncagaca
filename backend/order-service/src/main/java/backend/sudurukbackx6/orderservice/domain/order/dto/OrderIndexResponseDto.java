package backend.sudurukbackx6.orderservice.domain.order.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
public class OrderIndexResponseDto {
    private Long memberId;

    private Long storeId;

    private int orderPrice;

    private List<MenuResponseDto> menus;
}
