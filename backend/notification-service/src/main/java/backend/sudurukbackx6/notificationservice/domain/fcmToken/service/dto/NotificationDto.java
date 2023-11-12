package backend.sudurukbackx6.notificationservice.domain.fcmToken.service.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NotificationDto {

    private String title;
    private String body;

    public NotificationDto(String title, String body) {
        this.title = title;
        this.body = body;
    }
}
