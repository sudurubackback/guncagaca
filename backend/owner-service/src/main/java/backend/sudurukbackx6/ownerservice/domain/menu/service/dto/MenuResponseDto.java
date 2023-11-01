package backend.sudurukbackx6.ownerservice.domain.menu.service.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
@Builder
public class MenuResponseDto {
    private String menuId;

    private String name;

    private int price; // 기본 가격

    private int totalPrice; // 옵션 포함 가격

    private int quantity;

    private String img;

    private String category;

    private List<int[]> options;

    public MenuResponseDto(String menuId, String name, int price, int totalPrice, int quantity, String img, String category, List<int[]> options) {
        this.menuId = menuId;
        this.name = name;
        this.price = price;
        this.totalPrice = totalPrice;
        this.quantity = quantity;
        this.img = img;
        this.category = category;
        this.options = options;
    }
}
