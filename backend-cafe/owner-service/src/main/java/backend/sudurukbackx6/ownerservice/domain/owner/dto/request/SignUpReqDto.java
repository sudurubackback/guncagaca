package backend.sudurukbackx6.ownerservice.domain.owner.dto.request;

import backend.sudurukbackx6.ownerservice.domain.owner.entity.Owners;
import lombok.*;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SignUpReqDto {
    String email;
    String password;
    String tel;
    Long business_id;
}
