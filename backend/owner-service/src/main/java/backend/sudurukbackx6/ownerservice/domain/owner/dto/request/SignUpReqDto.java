package backend.sudurukbackx6.ownerservice.domain.owner.dto.request;

import backend.sudurukbackx6.ownerservice.domain.owner.entity.Owners;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SignUpReqDto {
    String email;
    String password;
    String tel;

    public Owners toEntity(){
        return Owners.builder().email(email)
                .password(password)
                .tel(tel).build();
    }
}
