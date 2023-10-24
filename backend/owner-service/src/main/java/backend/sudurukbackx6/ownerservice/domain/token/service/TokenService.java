package backend.sudurukbackx6.ownerservice.domain.token.service;

import backend.sudurukbackx6.ownerservice.domain.owner.dto.response.SignInResDto;
import backend.sudurukbackx6.ownerservice.domain.owner.entity.Owners;

public interface TokenService {
    SignInResDto createRefreshToken(Owners owners);
    String createAccessToken(String refreshToken);
    boolean tokenMathchEmail(String token, String email);
}
