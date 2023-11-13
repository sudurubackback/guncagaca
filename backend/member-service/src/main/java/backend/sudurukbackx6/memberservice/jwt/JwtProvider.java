package backend.sudurukbackx6.memberservice.jwt;

import backend.sudurukbackx6.memberservice.domain.member.entity.Member;
import backend.sudurukbackx6.memberservice.domain.member.repository.MemberRepository;
import io.jsonwebtoken.*;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.Date;
import java.util.HashMap;

@Component
@RequiredArgsConstructor
@Configuration
public class JwtProvider {
    private final MemberRepository memberRepository;
    private final JwtProperties jwtProperties;

    private String secret;
    private static final Long ACCESS_TOKEN_EXPIRATION_TIME = 1000 * 60 * 60 * 2L; // 2 hours -> 테스트 편의성을 위해 30 days
    private static final Long REFRESH_TOKEN_EXPIRATION_TIME = 1000 * 60 * 60 * 24L; // 1 days

    @PostConstruct
    public void init() {
        this.secret = jwtProperties.getSecret();
    }
    /**
     * AccessToken 생성
     */
    public TokenDto createAccessToken(String nickname, String email) {
        HashMap<String, Object> claim = new HashMap<>();
        claim.put("nickname", nickname);
        claim.put("email", email);
        return createJwt("ACCESS_TOKEN", ACCESS_TOKEN_EXPIRATION_TIME, claim);
    }

    /**
     * RefreshToken 생성
     */
    public TokenDto createRefreshToken(String nickname, String email) {
        HashMap<String, Object> claim = new HashMap<>();
        claim.put("nickname", nickname);
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
    public Member extractUser(String token) {
        String refreshToken = token.substring(7);
        String email = (String) get(refreshToken).get("email");

        Member member = memberRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("사용자 이메일을 찾을수 없습니다."));
        return member;
    }

    /**
     * 이메일 추출
     */
    public String extractEmail(String token) {
        String refreshToken = token.substring(7);
        String email = (String) get(refreshToken).get("email");

        memberRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("사용자 이메일을 찾을수 없습니다."));
        return email;
    }
}
