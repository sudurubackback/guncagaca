package backend.sudurukbackx6.ownerservice.domain.owner.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class StoreOrderResponse {

    private Long memberId;
    private LocalDateTime orderTime;
    private String status;
    private Boolean takeoutYn;
    private List<Menu> menuList;
    private int price;

    @Getter
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Menu {

        private String menuId;
        private String menuName;
        private int price;
        private int totalPrice;
        private int quantity;
        private String img;
        private String category;
        private List<Option> options;

        @Getter
        @Builder
        @NoArgsConstructor
        @AllArgsConstructor
        public static class Option {

            private String optionName;
            private String selectedOption;
        }
    }
}