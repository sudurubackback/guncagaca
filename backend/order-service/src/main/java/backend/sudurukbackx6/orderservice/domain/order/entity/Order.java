package backend.sudurukbackx6.orderservice.domain.order.entity;

import backend.sudurukbackx6.orderservice.domain.menu.entity.Menu;
import lombok.*;
import org.springframework.data.mongodb.core.mapping.Document;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Builder
@Getter
@Setter
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

    // 결제 영수증 id (취소할때 사용)
    private String receiptId;

    @Column(name = "order_time")
    private LocalDateTime orderTime;

    private Status status;

    private boolean takeoutYn;

    private boolean reviewYn;

    private List<Menu> menus;

    private int price;

    public void updateStatus(Status status) {
        this.status = status;
    }
}
