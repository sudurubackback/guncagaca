package backend.sudurukbackx6.ownerservice.domain.token.service;

import backend.sudurukbackx6.ownerservice.domain.owner.dto.response.SignInResDto;
import backend.sudurukbackx6.ownerservice.domain.owner.entity.Owners;
import backend.sudurukbackx6.ownerservice.domain.owner.service.OwnerService;
import backend.sudurukbackx6.ownerservice.domain.token.config.JwtTokenProvider;
import backend.sudurukbackx6.ownerservice.redis.util.RedisUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.Duration;

@RequiredArgsConstructor
@Service("TokenService")
public class TokenServiceImpl implements TokenService{

    private final JwtTokenProvider tokenProvider;
    private final OwnerService ownerService;
    private final RedisUtil redisUtil;

    @Override
    public SignInResDto createRefreshToken(Owners owners) {
        String refreshToken = tokenProvider.generateToken(owners, Duration.ofDays(1));
        String accessToken = tokenProvider.generateToken(owners, Duration.ofHours(2));
        redisUtil.saveRefreshToken(owners.getEmail(), refreshToken);

        return new SignInResDto(refreshToken, accessToken);
    }

    @Override
    public String createAccessToken(String header) {
        String parsedToken = header.substring("Bearer ".length()).trim();
        System.out.println(parsedToken);
        String email = tokenProvider.getUserEmail(parsedToken);
        System.out.println(email);
        if (redisUtil.isMatchToken(email, parsedToken)) {
            Owners owner = ownerService.findByEmail(email);
            return tokenProvider.generateToken(owner, Duration.ofHours(2));
        } else {
            throw new IllegalArgumentException("Unexpected token");
        }
    }

    @Override
    public boolean tokenMathchEmail(String token, String email) {
        String emailFromToken = tokenProvider.getUserEmail(token);
        return emailFromToken != null && emailFromToken.equals(email);
    }
}
