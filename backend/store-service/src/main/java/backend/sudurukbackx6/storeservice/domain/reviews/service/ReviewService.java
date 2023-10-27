package backend.sudurukbackx6.storeservice.domain.reviews.service;

import backend.sudurukbackx6.storeservice.domain.reviews.service.dto.ReviewSaveRequest;

public interface ReviewService {
    void reviewSave(String token, Long cafeId, ReviewSaveRequest request);
    void reviewDelete(String token, Long cafeId, Long reviewId);
}
