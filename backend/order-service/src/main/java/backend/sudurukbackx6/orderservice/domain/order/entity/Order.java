package backend.sudurukbackx6.orderservice.domain.order.entity;

import backend.sudurukbackx6.orderservice.domain.menu.entity.Menu;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.mapping.Document;

import javax.persistence.Column;
import javax.persistence.Id;
import java.time.LocalDateTime;
import java.util.List;

@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "order")
public class Order {

    @Id
    private String id;

    @Column(name = "member_id")
    private Long memberId;

    @Column(name = "store_id")
    private Long storeId;

    @Column(name = "order_time")
    private LocalDateTime orderTime;

    private Status status;

    private boolean takeoutYn;

    private List<Menu> menus;

    private int price;
}
