package backend.sudurukbackx6.storeservice.domain.reviews.service;

import backend.sudurukbackx6.storeservice.domain.reviews.entity.Review;
import backend.sudurukbackx6.storeservice.domain.reviews.service.dto.MyReviewResponse;
import backend.sudurukbackx6.storeservice.domain.reviews.service.dto.ReviewDto;

import java.util.List;

public interface ReviewService {
    ReviewDto.Response reviewSave(String token, Long cafeId, Long orderId, ReviewDto.Request request);
    void reviewDelete(String token, Long cafeId, Long reviewId);

    List<MyReviewResponse> getReviewByMemberId(Long memberId);
}
