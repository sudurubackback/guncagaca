package backend.sudurukbackx6.memberservice.domain.member.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class MypageResponse {

    public Long memberId;
    public String email;
    public String nickname;

    @Builder
    public MypageResponse(Long memberId, String email, String nickname) {
        this.memberId = memberId;
        this.email = email;
        this.nickname = nickname;
    }
}
