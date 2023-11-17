package backend.sudurukbackx6.ownerservice.domain.owner.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class SignInReqDto {
    String email;
    String password;
}
