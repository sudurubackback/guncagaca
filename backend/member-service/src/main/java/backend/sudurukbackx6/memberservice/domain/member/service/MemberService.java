package backend.sudurukbackx6.memberservice.domain.member.service;

import backend.sudurukbackx6.memberservice.domain.member.dto.SignRequestDto;
import backend.sudurukbackx6.memberservice.domain.member.dto.SignResponseDto;
import backend.sudurukbackx6.memberservice.domain.member.entity.Member;
import backend.sudurukbackx6.memberservice.domain.member.repository.MemberRepository;
import backend.sudurukbackx6.memberservice.jwt.JwtProvider;
import backend.sudurukbackx6.memberservice.jwt.TokenDto;
import backend.sudurukbackx6.memberservice.redis.util.RedisUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@Slf4j
@RequiredArgsConstructor
public class MemberService {
    private final MemberRepository memberRepository;
    private final JwtProvider jwtProvider;
    private final RedisUtil redisUtil;

    public SignResponseDto getSign(SignRequestDto signRequestDto) {

        Optional<Member> optionalMember = memberRepository.findByEmail(signRequestDto.getEmail());

        if (!optionalMember.isPresent()) { // 토큰만 발급
            Member member = Member.builder()
                    .email(signRequestDto.getEmail())
                    .nickname(signRequestDto.getNickname())
                    .build();
            memberRepository.save(member);
        }

        TokenDto accessToken = jwtProvider.createAccessToken(signRequestDto.getNickname(), signRequestDto.getEmail());
        TokenDto refreshToken = jwtProvider.createRefreshToken(signRequestDto.getNickname(), signRequestDto.getEmail());

        redisUtil.saveRefreshToken(signRequestDto.getEmail(), refreshToken.getToken());
        return SignResponseDto.builder()
                .accessToken(accessToken.getToken())
                .refreshToken(refreshToken.getToken())
                .build();
    }

    public SignResponseDto refreshAccessToken(String token) {
        String email = jwtProvider.extractEmail(token);
        String refreshTokens = redisUtil.getRefreshTokens(email);
        log.info(refreshTokens);

        Member member = jwtProvider.extractUser(token);

        TokenDto accessToken = jwtProvider.createAccessToken(member.getNickname(), member.getEmail());
        TokenDto refreshToken = jwtProvider.createRefreshToken(member.getNickname(), member.getEmail());

        redisUtil.saveRefreshToken(member.getEmail(), refreshToken.getToken());

        return SignResponseDto.builder()
                .accessToken(accessToken.getToken())
                .refreshToken(refreshToken.getToken())
                .build();
    }
}
