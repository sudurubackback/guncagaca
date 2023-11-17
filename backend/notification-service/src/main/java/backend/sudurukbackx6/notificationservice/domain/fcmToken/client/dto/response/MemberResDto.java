package backend.sudurukbackx6.notificationservice.domain.fcmToken.client.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
public class MemberResDto {
    String firebaseToken;
}
