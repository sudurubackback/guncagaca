package backend.sudurukbackx6.storeservice.domain.reviews.service;

import java.util.List;
import java.util.Objects;

import backend.sudurukbackx6.storeservice.domain.reviews.client.MemberServiceClient;
import backend.sudurukbackx6.storeservice.domain.reviews.client.dto.MemberInfoResponse;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import backend.sudurukbackx6.storeservice.domain.reviews.entity.Review;
import backend.sudurukbackx6.storeservice.domain.reviews.repository.ReviewRepository;
import backend.sudurukbackx6.storeservice.domain.reviews.service.dto.ReviewSaveRequest;
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

    /**
     * 리뷰를 썼는지 확인 주문 메뉴에 해당하는 true값으로
     * 쓰는 사람이 주문한 사람인지 확인하는 절차
     * ErrorCode Handling 해야함.
     * 인가를 어떻게 할지 -> 인가를 통해서 Bearer 처리를 하고, 이 다음 service 메서드를 진행한다.
     */

    @Override
    public void reviewSave(String token, Long cafeId, ReviewSaveRequest request) {
        Store store = storeRepository.findById(cafeId).orElseThrow(RuntimeException::new);
        MemberInfoResponse memberInfo = memberServiceClient.getMemberInfo(token);

        log.info("memberInfo={}", memberInfo.getEmail());
        Review review = Review.builder()
                .star(request.getStar())
                .comment(request.getContent())
                .store(store)
                .memberId(memberInfo.getId())
                .build();

        reviewRepository.save(review);

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
