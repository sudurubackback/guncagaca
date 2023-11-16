package backend.sudurukbackx6.orderservice.domain.order.client.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class MemberInfoResponse {
    private String email;
    private Long id;
    private String nickname;

}
