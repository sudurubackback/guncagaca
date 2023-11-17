package backend.sudurukbackx6.orderservice.domain.order.client.dto.response;

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
