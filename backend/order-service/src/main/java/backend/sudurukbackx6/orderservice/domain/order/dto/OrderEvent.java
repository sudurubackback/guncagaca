package backend.sudurukbackx6.orderservice.domain.order.dto;

import backend.sudurukbackx6.orderservice.domain.order.entity.Status;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderEvent {
    private Long memberId;
    private Status status;
    private Long storeId;
    private String storeName;
    private String reason;

    public OrderEvent(Long memberId, Status status, Long storeId, String storeName, String reason) {
        this.memberId = memberId;
        this.status = status;
        this.storeId = storeId;
        this.storeName = storeName;
        this.reason = reason;
    }
}
