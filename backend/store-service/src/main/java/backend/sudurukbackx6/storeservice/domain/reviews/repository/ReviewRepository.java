package backend.sudurukbackx6.storeservice.domain.reviews.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import backend.sudurukbackx6.storeservice.domain.reviews.entity.Review;

public interface ReviewRepository extends JpaRepository<Review, Long> {
}
