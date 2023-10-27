package backend.sudurukbackx6.orderservice.domain.order.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import java.util.HashMap;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Menu {

    @Column(name = "menu_id")
    private String menuId;

    private int quantity;

    private HashMap<Integer, Integer> option;
}
