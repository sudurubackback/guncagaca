package backend.sudurukbackx6.ownerservice.domain.owner.client.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
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
    private int price;


    public static class Menu {

        @Column(name = "menu_id")
        private String menuId;

        private String menuName;

        private int price;

        private int totalPrice; // 옵션 포함 가격

        private int quantity;

        private String img;

        private String category;

        private List<Option> options;
    }

    public static class Option {

        private String optionName;
        private String selectedOption;
    }

}
