package backend.sudurukbackx6.ownerservice.domain.owner.dto.response;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OwnerSignupEvent {
    private String email;
    private String password;
    private String tel;
    private Long business_id;
}
