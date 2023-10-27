package backend.sudurukbackx6.storeservice.domain.reviews.service;

import backend.sudurukbackx6.storeservice.domain.reviews.service.dto.ReviewSaveRequest;

public interface ReviewService {
    void reviewSave(Long memberId, Long cafeId, ReviewSaveRequest request);
    void reviewDelete(Long memberId, Long cafeId, Long reviewId);
}
