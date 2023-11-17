package backend.sudurukbackx6.storeservice.domain.likes.repository;

import backend.sudurukbackx6.storeservice.domain.likes.entity.Likey;
import backend.sudurukbackx6.storeservice.domain.store.entity.Store;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface LikeRepository extends JpaRepository<Likey, Long> {

    // 찜 가게 여부 조회
    Optional<Likey> findByMemberIdAndStoreId(Long memberId, Long storeId);

    boolean existsByMemberIdAndStoreId(Long memberId, Long storeId);

    List<Likey> findByMemberId(Long memberId);
}
