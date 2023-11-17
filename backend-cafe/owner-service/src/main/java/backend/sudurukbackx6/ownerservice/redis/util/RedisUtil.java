package backend.sudurukbackx6.ownerservice.redis.util;

import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import java.util.concurrent.TimeUnit;

@Component
@RequiredArgsConstructor
public class RedisUtil {

    private final RedisTemplate<String, Object> redisTemplate;

    //이메일로 전송한 인증코드 저장
    public void saveCode(String email, String code) {
        redisTemplate.opsForHash().put("email:code", email, code);
        redisTemplate.expire("email:code", 5, TimeUnit.MINUTES);
    }

    //이메일로 인증코드 조회
    public String getCode(String email) {
        return (String) redisTemplate.opsForHash().get("email:code", email);
    }

    //refreshtoken 저장
    public void saveRefreshToken(String email, String refreshToken) {
        redisTemplate.opsForHash().put("email:token", email, refreshToken);
        redisTemplate.expire("email:token", 2, TimeUnit.HOURS);
    }

    //refreshtoken 조회

    public String getRefreshTokens(String email) {
        return (String) redisTemplate.opsForHash().get("email:token", email);
    }

    public boolean isMatchToken(String email, String header){
        String redisToken = getRefreshTokens(email);
        return redisToken != null && redisToken.equals(header.substring(7));
    }

    //redis에 있는 refreshtoken을 삭제해준다,
    public void deleteRefreshToken(String email) {
        System.out.println("deleteRefreshToken email = "+email);
        redisTemplate.opsForHash().delete("email:token", email);
    }


}
