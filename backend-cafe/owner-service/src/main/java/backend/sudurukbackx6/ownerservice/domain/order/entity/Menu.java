package backend.sudurukbackx6.ownerservice.domain.order.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import java.util.List;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Menu {

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