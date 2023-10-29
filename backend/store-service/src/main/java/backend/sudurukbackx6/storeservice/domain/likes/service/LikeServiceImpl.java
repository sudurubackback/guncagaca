package backend.sudurukbackx6.storeservice.domain.likes.service;

import backend.sudurukbackx6.storeservice.domain.likes.entity.Like;
import backend.sudurukbackx6.storeservice.domain.likes.repository.LikeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
@RequiredArgsConstructor
public class LikeServiceImpl implements LikeService{

    private final LikeRepository likeRepository;

    // 찜 토글
    @Override
    public boolean toggleLike(Long memberId, Long storeId) {
        boolean exists = likeRepository.existsByMemberIdAndStoreId(memberId, storeId);

        if (exists) {
            // 이미 찜한 상태라면 찜 해제
            // TODO Exception 처리
            Like existingLike = likeRepository.findByMemberIdAndStoreId(memberId, storeId).orElseThrow(() -> new IllegalArgumentException("Like not found"));
            likeRepository.delete(existingLike);
            return false;
        } else {
            // 찜이 없다면 새로 찜 등록
            Like like = Like.builder()
                    .memberId(memberId)
                    .storeId(storeId)
                    .build();
            likeRepository.save(like);
            return true;
        }
    }
}
