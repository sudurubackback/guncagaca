package backend.sudurukbackx6.ownerservice.domain.owner.dto.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UpdatePwReqDto {
    String newpassword;
    String password;
}
