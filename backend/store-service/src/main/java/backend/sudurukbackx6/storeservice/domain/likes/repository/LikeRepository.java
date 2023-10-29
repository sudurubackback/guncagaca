package backend.sudurukbackx6.storeservice.domain.likes.repository;

import backend.sudurukbackx6.storeservice.domain.likes.entity.Like;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface LikeRepository extends JpaRepository<Like, Long> {

    // 찜 가게 여부 조회
    Optional<Like> findByMemberIdAndStoreId(Long memberId, Long storeId);

    boolean existsByMemberIdAndStoreId(Long memberId, Long storeId);
}
