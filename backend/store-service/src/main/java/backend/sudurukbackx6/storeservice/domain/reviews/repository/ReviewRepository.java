package backend.sudurukbackx6.storeservice.domain.reviews.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import backend.sudurukbackx6.storeservice.domain.reviews.entity.Review;

import java.util.List;

public interface ReviewRepository extends JpaRepository<Review, Long> {

    // 가게 리뷰 최신순
    List<Review> findByStoreIdOrderByIdDesc(Long storeId);

    List<Review> getReviewByMemberId(Long memberId);

}
