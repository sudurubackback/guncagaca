package backend.sudurukbackx6.orderservice.domain.order.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;

import javax.persistence.Column;
import java.util.List;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Menu {
    @Id
    private String id;

    @Column(name = "menu_id")
    private String menuId;

    private int quantity;

    private List<int[]> option;
}
