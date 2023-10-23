package backend.sudurukbackx6.memberservice.domain.member.service;

import backend.sudurukbackx6.memberservice.domain.member.dto.SignRequestDto;
import backend.sudurukbackx6.memberservice.domain.member.dto.SignResponseDto;
import backend.sudurukbackx6.memberservice.domain.member.entity.Member;
import backend.sudurukbackx6.memberservice.domain.member.repository.MemberRepository;
import backend.sudurukbackx6.memberservice.jwt.JwtProvider;
import backend.sudurukbackx6.memberservice.jwt.TokenDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class MemberService {
    private final MemberRepository memberRepository;
    private final JwtProvider jwtProvider;

    public SignResponseDto getSign(SignRequestDto signRequestDto) {

        Optional<Member> optionalMember = memberRepository.findByEmail(signRequestDto.getEmail());

        if (!optionalMember.isPresent()) { // 토큰만 발급
            Member member = Member.builder()
                    .email(signRequestDto.getEmail())
                    .nickname(signRequestDto.getNickname())
                    .tel(signRequestDto.getTel())
                    .build();
            memberRepository.save(member);
        }

        TokenDto accessToken = jwtProvider.createAccessToken(signRequestDto.getNickname(), signRequestDto.getEmail());
        TokenDto refreshToken = jwtProvider.createRefreshToken(signRequestDto.getNickname(), signRequestDto.getEmail());


        return SignResponseDto.builder()
                .accessToken(accessToken.getToken())
                .refreshToken(refreshToken.getToken())
                .build();
    }
}
