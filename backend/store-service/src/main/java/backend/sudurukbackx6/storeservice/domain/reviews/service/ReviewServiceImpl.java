package backend.sudurukbackx6.storeservice.domain.reviews.service;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import backend.sudurukbackx6.storeservice.domain.reviews.client.MemberServiceClient;
import backend.sudurukbackx6.storeservice.domain.reviews.client.dto.MemberInfoResponse;
import backend.sudurukbackx6.storeservice.domain.reviews.service.dto.MyReviewResponse;
import backend.sudurukbackx6.storeservice.domain.store.service.StoreServiceImpl;
import backend.sudurukbackx6.storeservice.global.kafka.KafkaEventService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import backend.sudurukbackx6.storeservice.domain.reviews.entity.Review;
import backend.sudurukbackx6.storeservice.domain.reviews.repository.ReviewRepository;
import backend.sudurukbackx6.storeservice.domain.reviews.service.dto.ReviewDto;
import backend.sudurukbackx6.storeservice.domain.store.entity.Store;
import backend.sudurukbackx6.storeservice.domain.store.repository.StoreRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.webjars.NotFoundException;

@Service
@Slf4j
@RequiredArgsConstructor
@Transactional
public class ReviewServiceImpl implements ReviewService{

    private final StoreRepository storeRepository;
    private final ReviewRepository reviewRepository;
    private final MemberServiceClient memberServiceClient;
    private final StoreServiceImpl storeService;
    private final KafkaEventService kafkaEventService;

    /**
     * 리뷰를 썼는지 확인 주문 메뉴에 해당하는 true값으로
     * 쓰는 사람이 주문한 사람인지 확인하는 절차
     * ErrorCode Handling 해야함.
     * 인가를 어떻게 할지 -> 인가를 통해서 Bearer 처리를 하고, 이 다음 service 메서드를 진행한다.
     */

    @Override
    public ReviewDto.Response reviewSave(String email, Long cafeId, String orderId, ReviewDto.Request request) {
        Store store = storeRepository.findById(cafeId).orElseThrow(()-> new NotFoundException("해당 가게를 찾을 수 없습니다."));
        MemberInfoResponse memberInfo = memberServiceClient.getMemberInfo(email);

        log.info("memberInfo={}", memberInfo.getEmail());
        Review review = Review.builder()
                .star(request.getStar())
                .comment(request.getComment())
                .store(store)
                .orderId(orderId)
                .memberId(memberInfo.getId())
                .build();

        reviewRepository.save(review);

        storeService.updateStarPoint(store.getId(), review.getStar());
        // 리뷰 작성 완료 처리
        updateOrderStatus(orderId);

        return new ReviewDto.Response(review);

    }

    @Override
    public void reviewDelete(String email, Long cafeId, Long reviewId) {
        Review review = reviewRepository.findById(reviewId).orElseThrow();
        MemberInfoResponse memberInfo = memberServiceClient.getMemberInfo(email);
        if(!Objects.equals(review.getMemberId(), memberInfo.getId())){
            throw new RuntimeException();
        }
        reviewRepository.deleteById(reviewId);
    }

    // 리뷰 작성완료 이벤트 발행
    @Override
    public void updateOrderStatus(String orderId) {

        kafkaEventService.eventPublish("reviewTopic", orderId);

    }

    @Override
    public List<MyReviewResponse> getReviewByMemberId(Long memberId) {
        // 최신순 조회
        List<Review> reviews = reviewRepository.getReviewByMemberIdOrderByIdDesc(memberId);

        return reviews.stream().map(MyReviewResponse::new).collect(Collectors.toList());
    }

}
