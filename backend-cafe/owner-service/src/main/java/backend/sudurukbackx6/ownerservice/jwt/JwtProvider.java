package backend.sudurukbackx6.ownerservice.jwt;

import backend.sudurukbackx6.ownerservice.domain.owner.entity.Owners;
import backend.sudurukbackx6.ownerservice.domain.owner.repository.OwnersRepository;
import io.jsonwebtoken.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;

@Component
@RequiredArgsConstructor
public class JwtProvider {
    private final OwnersRepository ownersRepository;

    private String secret = "dkssudsksmsdmswlddlfkrhgksmsepsjsms";
    private static final Long ACCESS_TOKEN_EXPIRATION_TIME = 1000 * 60 * 60 * 2L; // 2 hours -> 테스트 편의성을 위해 30 days
    private static final Long REFRESH_TOKEN_EXPIRATION_TIME = 1000 * 60 * 60 * 24L; // 1 days

    /**
     * AccessToken 생성
     */
    public TokenDto createAccessToken(String email) {
        HashMap<String, Object> claim = new HashMap<>();
        claim.put("nickname", "OWNER");
        claim.put("email", email);
        return createJwt("ACCESS_TOKEN", ACCESS_TOKEN_EXPIRATION_TIME, claim);
    }

    /**
     * RefreshToken 생성
     */
    public TokenDto createRefreshToken(String email) {
        HashMap<String, Object> claim = new HashMap<>();
        claim.put("nickname", "OWNER");
        claim.put("email", email);
        return createJwt("REFRESH_TOKEN", REFRESH_TOKEN_EXPIRATION_TIME, claim);
    }

    /**
     * JWT 생성
     */
    public TokenDto createJwt(String subject, Long expiration, HashMap<String, Object> claim) {
        JwtBuilder jwtBuilder = Jwts.builder()
                .setHeaderParam("typ", "JWT")
                .setSubject(subject)
                .setIssuedAt(new Date())
                .signWith(SignatureAlgorithm.HS256, secret);
        // claim 없는 경우 추가
        if (claim != null) {
            jwtBuilder.setClaims(claim);
        }
        // 기간
        Date date = null;
        if (expiration != null) {
            date = new Date(new Date().getTime() + expiration);
            jwtBuilder.setExpiration(date);
        }
        String token = jwtBuilder.compact();
        return new TokenDto(token, date);
    }

    /**
     * 복호화
     */
    public Claims get(String jwt) throws JwtException {
        return Jwts
                .parser()
                .setSigningKey(secret)
                .parseClaimsJws(jwt)
                .getBody();
    }

    /**
     * 토큰 만료 여부 체크
     *
     * @return true : 만료됨, false : 만료되지 않음
     */
    public boolean isExpiration(String jwt) throws JwtException {
        try {
            return get(jwt).getExpiration().before(new Date());
        } catch (ExpiredJwtException e) {
            return true;
        }
    }

    /**
     * 사용자 추출
     */
    public Owners extractUser(String token) {
        String refreshToken = token.substring(7);
        String email = (String) get(refreshToken).get("email");

        Owners owner = ownersRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("사용자 이메일을 찾을수 없습니다."));
        return owner;
    }

    /**
     * 이메일 추출
     */
    public String extractEmail(String token) {
        String refreshToken = token.substring(7);
        String email = (String) get(refreshToken).get("email");

        System.out.println(email);

        ownersRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("사용자 이메일을 찾을수 없습니다."));
        return email;
    }
}
