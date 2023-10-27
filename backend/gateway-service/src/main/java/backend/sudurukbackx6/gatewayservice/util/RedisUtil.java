package backend.sudurukbackx6.gatewayservice.util;

import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class RedisUtil {

    private final RedisTemplate<String, Object> redisTemplate;

    //refreshtoken 조회
    public String getRefreshTokens(String email) {
        return (String) redisTemplate.opsForHash().get("email:token", email);
    }

    // token 일치 여부 확인
    public boolean isMatchToken(String email, String refreshToken){
        String redisToken = getRefreshTokens(email);
        return redisToken != null && redisToken.equals(refreshToken);
    }
}
