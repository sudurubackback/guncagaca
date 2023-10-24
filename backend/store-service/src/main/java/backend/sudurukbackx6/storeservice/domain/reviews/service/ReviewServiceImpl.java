package backend.sudurukbackx6.storeservice.domain.reviews.service;

import java.util.List;

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

    @Override
    public void reviewSave(Long cafeId, ReviewSaveRequest request) {
        Store store = storeRepository.findById(cafeId).orElseThrow(RuntimeException::new);

        Review review = Review.builder()
                .star(request.getStar())
                .comment(request.getContent())
                .store(store)
                .build();

        reviewRepository.save(review);

    }

    @Override
    public void reviewDelete(Long cafeId, Long reviewId) {
        Store store = storeRepository.findById(cafeId).orElseThrow(RuntimeException::new);
        List<Review> reviewList = store.getReview();

        for (Review review : reviewList) {
            if(reviewId == review.getId()) reviewRepository.delete(review);
        }
    }
}
