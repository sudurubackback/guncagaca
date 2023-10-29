package backend.sudurukbackx6.storeservice.domain.reviews.service;

import backend.sudurukbackx6.storeservice.domain.reviews.service.dto.ReviewDto;

public interface ReviewService {
    ReviewDto.Response reviewSave(String token, Long cafeId, Long orderId, ReviewDto.Request request);
    void reviewDelete(String token, Long cafeId, Long reviewId);
}
