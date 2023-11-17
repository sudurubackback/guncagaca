package backend.sudurukbackx6.orderservice.domain.order.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
public class OrderCancelRequestDto {

    private String reason;
    private String receiptId;
    private String orderId;
}
