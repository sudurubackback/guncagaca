package backend.sudurukbackx6.storeservice.domain.likes.service;

public interface LikeService {
    boolean toggleLike(Long memberId, Long storeId);
}
