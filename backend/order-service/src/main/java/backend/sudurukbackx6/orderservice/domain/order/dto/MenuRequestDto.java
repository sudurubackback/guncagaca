package backend.sudurukbackx6.orderservice.domain.order.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
public class MenuRequestDto {
    private String menuId;

    private String name;

    private int price; // 기본 가격

    private int totalPrice; // 옵션 포함 가격

    private int quantity;

    private String img;

    private String category;

    private List<OptionRequestDto> options;
}
