package backend.sudurukbackx6.notificationservice.domain.fcmToken.service.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class FCMOwnerReqDto {
    private Long storeId;
    private String title;
    private String body;

    @Builder
    public FCMOwnerReqDto(Long storeId, String title, String body) {
        this.storeId = storeId;
        this.title = title;
        this.body = body;
    }
}
