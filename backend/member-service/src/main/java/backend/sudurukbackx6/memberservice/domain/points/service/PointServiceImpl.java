package backend.sudurukbackx6.memberservice.domain.points.service;

import backend.sudurukbackx6.memberservice.domain.member.entity.Member;
import backend.sudurukbackx6.memberservice.domain.member.repository.MemberRepository;
import backend.sudurukbackx6.memberservice.domain.points.entity.Point;
import backend.sudurukbackx6.memberservice.domain.points.repository.PointRepository;
import backend.sudurukbackx6.memberservice.domain.points.service.dto.PointSaveRequest;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
@Transactional
public class PointServiceImpl implements PointService {

    private final MemberRepository memberRepository;
    private final PointRepository pointRepository;

    @Override
    public void pointPlus(String email, Long cafeId, PointSaveRequest request) {
        Member member = memberRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("이메일 정보가 존재하지 않습니다."));

        Long memberId = member.getId();

        Point point = Point.builder()
                .point(request.getPoint())
                .member(member)
                .storeId(cafeId)
                .build();

        pointRepository.save(point);

        // 해당 멤버의 포인트 업데이트
        int currentPoints = member.getPoints().stream()
                .filter(p -> Objects.equals(p.getStoreId(), cafeId))
                .map(Point::getPoint)
                .findFirst()
                .orElse(0);

        int newPoints = currentPoints + request.getPoint(); // 새로운 포인트 계산

        // 해당 카페의 포인트 업데이트
        List<Point> cafePoints = member.getPoints().stream()
                .filter(p -> Objects.equals(p.getStoreId(), cafeId))
                .collect(Collectors.toList());
        if (!cafePoints.isEmpty()) {
            cafePoints.get(0).setPoint(newPoints);
            pointRepository.save(cafePoints.get(0));
        }
    }

    @Override
    public void pointMinus(String email, Long cafeId, PointSaveRequest request) {
        Member member = memberRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("이메일 정보가 존재하지 않습니다."));

        Long memberId = member.getId();

        Point point = Point.builder()
                .point(request.getPoint())
                .member(member)
                .storeId(cafeId)
                .build();

        pointRepository.save(point);

        // 해당 멤버의 포인트 업데이트
        int currentPoints = member.getPoints().stream()
                .filter(p -> Objects.equals(p.getStoreId(), cafeId))
                .map(Point::getPoint)
                .findFirst()
                .orElse(0);

        int newPoints = currentPoints - request.getPoint(); // 새로운 포인트 계산

        if (newPoints < 0) {
            throw new IllegalArgumentException("포인트가 부족합니다.");
        }
        else{
            // 해당 카페의 포인트 업데이트
            List<Point> cafePoints = member.getPoints().stream()
                    .filter(p -> Objects.equals(p.getStoreId(), cafeId))
                    .collect(Collectors.toList());
            if (!cafePoints.isEmpty()) {
                cafePoints.get(0).setPoint(newPoints);
                pointRepository.save(cafePoints.get(0));

            }
        }
    }
}