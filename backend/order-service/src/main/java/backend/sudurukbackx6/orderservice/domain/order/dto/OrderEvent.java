package backend.sudurukbackx6.orderservice.domain.order.dto;

import backend.sudurukbackx6.orderservice.domain.order.entity.Status;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderEvent {
    private Long memberId;
    private Status status;

    public OrderEvent(Long memberId, Status status) {
        this.memberId = memberId;
        this.status = status;
    }
}
