package backend.sudurukbackx6.orderservice.domain.menu.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import javax.persistence.Column;
import java.util.List;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Menu {

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
