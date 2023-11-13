package backend.sudurukbackx6.storeservice.domain.reviews.service;

import backend.sudurukbackx6.storeservice.domain.reviews.entity.Review;
import backend.sudurukbackx6.storeservice.domain.reviews.service.dto.MyReviewResponse;
import backend.sudurukbackx6.storeservice.domain.reviews.service.dto.ReviewDto;

import java.util.List;

public interface ReviewService {
    ReviewDto.Response reviewSave(String email, Long cafeId, String orderId, ReviewDto.Request request);
    void reviewDelete(String email, Long cafeId, Long reviewId);

    void updateOrderStatus(String orderId);

    List<MyReviewResponse> getReviewByMemberId(Long memberId);
}
