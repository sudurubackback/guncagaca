package backend.sudurukbackx6.ownerservice.domain.menu.service.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
public class OrderRequestDto {
    private String memberId;

    private String storeId;

    private int orderPrice;

    private List<MenuRequestDto> menus;
}
