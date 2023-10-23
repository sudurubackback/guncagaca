package backend.sudurukbackx6.memberservice.domain.member.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class SignResponseDto {
    public String accessToken;
    public String refreshToken;

    @Builder
    public SignResponseDto(String accessToken, String refreshToken) {
        this.accessToken = accessToken;
        this.refreshToken = refreshToken;
    }
}
