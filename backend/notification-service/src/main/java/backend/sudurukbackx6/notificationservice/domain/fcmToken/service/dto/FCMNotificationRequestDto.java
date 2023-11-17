package backend.sudurukbackx6.notificationservice.domain.fcmToken.service.dto;

import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Setter
public class FCMNotificationRequestDto {

	private Long memberId;
	private String title;
	private String body;
//	private String imageUrl;
//	private String productCode;
}
