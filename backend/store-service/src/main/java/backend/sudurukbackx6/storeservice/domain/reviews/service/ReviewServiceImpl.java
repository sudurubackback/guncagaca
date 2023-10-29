package backend.sudurukbackx6.storeservice.domain.reviews.service;

import java.util.Objects;

import backend.sudurukbackx6.storeservice.domain.reviews.client.MemberServiceClient;
import backend.sudurukbackx6.storeservice.domain.reviews.client.dto.MemberInfoResponse;
import backend.sudurukbackx6.storeservice.domain.store.service.StoreServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import backend.sudurukbackx6.storeservice.domain.reviews.entity.Review;
import backend.sudurukbackx6.storeservice.domain.reviews.repository.ReviewRepository;
import backend.sudurukbackx6.storeservice.domain.reviews.service.dto.ReviewDto;
import backend.sudurukbackx6.storeservice.domain.store.entity.Store;
import backend.sudurukbackx6.storeservice.domain.store.repository.StoreRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
@Transactional
public class ReviewServiceImpl implements ReviewService{

    private final StoreRepository storeRepository;
    private final ReviewRepository reviewRepository;
    private final MemberServiceClient memberServiceClient;
    private final StoreServiceImpl storeService;

    /**
     * 리뷰를 썼는지 확인 주문 메뉴에 해당하는 true값으로
     * 쓰는 사람이 주문한 사람인지 확인하는 절차
     * ErrorCode Handling 해야함.
     * 인가를 어떻게 할지 -> 인가를 통해서 Bearer 처리를 하고, 이 다음 service 메서드를 진행한다.
     */

    @Override
    public ReviewDto.Response reviewSave(String token, Long cafeId, Long orderId, ReviewDto.Request request) {
        Store store = storeRepository.findById(cafeId).orElseThrow(RuntimeException::new);
        MemberInfoResponse memberInfo = memberServiceClient.getMemberInfo(token);

        log.info("memberInfo={}", memberInfo.getEmail());
        Review review = Review.builder()
                .star(request.getStar())
                .comment(request.getComment())
                .store(store)
                .memberId(memberInfo.getId())
                .build();

        reviewRepository.save(review);

        storeService.updateStarPoint(store.getId(), review.getStar());
        // TODO 해당 주문에 대한 리뷰 작성완료 처리

        return new ReviewDto.Response(review);

    }

    @Override
    public void reviewDelete(String token, Long cafeId, Long reviewId) {
        Review review = reviewRepository.findById(reviewId).orElseThrow();
        MemberInfoResponse memberInfo = memberServiceClient.getMemberInfo(token);
        if(!Objects.equals(review.getMemberId(), memberInfo.getId())){
            throw new RuntimeException();
        }
        reviewRepository.deleteById(reviewId);
    }
}
