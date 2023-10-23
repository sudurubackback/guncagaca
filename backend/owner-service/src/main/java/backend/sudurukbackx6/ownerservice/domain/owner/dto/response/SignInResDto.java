package backend.sudurukbackx6.ownerservice.domain.owner.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class SignInResDto {
    private String accessToken;
    private String refreshToken;
}
