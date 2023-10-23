package backend.sudurukbackx6.memberservice.domain.member.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class SignRequestDto {
    public String nickname;
    public String email;
    public String tel;
}
