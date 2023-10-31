package backend.sudurukbackx6.memberservice.domain.member.service;

import backend.sudurukbackx6.memberservice.domain.member.client.StoreFeignClient;
import backend.sudurukbackx6.memberservice.domain.member.client.response.StoreResponse;
import backend.sudurukbackx6.memberservice.domain.member.dto.MyPointsResponse;
import backend.sudurukbackx6.memberservice.domain.member.dto.MypageResponseDto;
import backend.sudurukbackx6.memberservice.domain.member.dto.SignRequestDto;
import backend.sudurukbackx6.memberservice.domain.member.dto.SignResponseDto;
import backend.sudurukbackx6.memberservice.domain.member.entity.Member;
import backend.sudurukbackx6.memberservice.domain.member.repository.MemberRepository;
import backend.sudurukbackx6.memberservice.domain.points.entity.Point;
import backend.sudurukbackx6.memberservice.domain.points.repository.PointRepository;
import backend.sudurukbackx6.memberservice.jwt.JwtProvider;
import backend.sudurukbackx6.memberservice.jwt.TokenDto;
import backend.sudurukbackx6.memberservice.redis.util.RedisUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
@Transactional
public class MemberService {
    private final MemberRepository memberRepository;
    private final PointRepository pointRepository;
    private final JwtProvider jwtProvider;
    private final RedisUtil redisUtil;
    private final StoreFeignClient storeFeignClient;

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

    public SignResponseDto refreshAccessToken(String email) {
        Member member = memberRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("이메일 정보가 존재하지 않습니다."));

        TokenDto accessToken = jwtProvider.createAccessToken(member.getNickname(), member.getEmail());
        TokenDto refreshToken = jwtProvider.createRefreshToken(member.getNickname(), member.getEmail());

        redisUtil.saveRefreshToken(member.getEmail(), refreshToken.getToken());

        return SignResponseDto.builder()
                .accessToken(accessToken.getToken())
                .refreshToken(refreshToken.getToken())
                .build();
    }

    public MypageResponseDto getMypage(String email) {
        Member member = memberRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("이메일 정보가 존재하지 않습니다."));

        return MypageResponseDto.builder()
                .memberId(member.getId())
                .email(member.getEmail())
                .nickname(member.getNickname())
                .build();
    }

    public MypageResponseDto changeNickname(String email, String nickname) {
        Member member = memberRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("이메일 정보가 존재하지 않습니다."));

        member.changeNickname(nickname);

        return MypageResponseDto.builder()
                .memberId(member.getId())
                .email(member.getEmail())
                .nickname(member.getNickname())
                .build();
    }


    public List<MyPointsResponse> myPoint(String email) {

        Member member = memberRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("이메일 정보가 존재하지 않습니다."));

        List<Point> pointList = member.getPoints();

        List<Long> cafeIds = pointList.stream()
                .map(Point::getStoreId)
                .distinct()
                .collect(Collectors.toList());

        List<MyPointsResponse> myPointsResponses = new ArrayList<>();

        for (Long cafeId : cafeIds) {
            StoreResponse storeInfo = storeFeignClient.cafeDetail(cafeId);
            String name = storeInfo.getName();
            String img = storeInfo.getImg();

            List<Point> cafePoints = pointList.stream()
                    .filter(p -> p.getStoreId().equals(cafeId))
                    .collect(Collectors.toList());

            int totalPoints = cafePoints.stream()
                    .mapToInt(Point::getPoint)
                    .sum();

            MyPointsResponse myPointsResponse = MyPointsResponse.builder()
                    .storeId(cafeId)
                    .point(totalPoints)
                    .name(name)
                    .img(img)
                    .build();

            myPointsResponses.add(myPointsResponse);
        }

        return myPointsResponses;
    }
}
