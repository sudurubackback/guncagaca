package backend.sudurukbackx6.notificationservice.domain.fcmToken.entity;

import lombok.Getter;
    import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public enum Status {

    ORDERED("주문"),
    REQUEST("주문접수"),
    CANCELED("주문취소"),
    COMPLETE("주문완료"),;

    private String status;

    Status(String status) {
        this.status = status;
    }

}
