package backend.sudurukbackx6.notificationservice.domain.fcmToken.service.dto;

import backend.sudurukbackx6.notificationservice.domain.fcmToken.entity.Status;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NotificationEvent {

    private Long memberId;
    private Status status;
    private Long storeId;
    private String storeName;
    private String reason;
    private String orderMenu;
}
