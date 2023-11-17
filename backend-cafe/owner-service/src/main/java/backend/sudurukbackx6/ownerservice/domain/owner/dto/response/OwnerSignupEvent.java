package backend.sudurukbackx6.ownerservice.domain.owner.dto.response;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OwnerSignupEvent {
    private Long ownerId;
    private String email;
    private String password;
    private String tel;
    private Long storeId;
    private String ip;
    private String ddns;
}
