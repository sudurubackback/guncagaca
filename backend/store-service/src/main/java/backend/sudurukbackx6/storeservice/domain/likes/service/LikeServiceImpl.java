package backend.sudurukbackx6.storeservice.domain.likes.service;

import backend.sudurukbackx6.storeservice.domain.likes.dto.LikeResponse;
import backend.sudurukbackx6.storeservice.domain.likes.dto.LikeToggleResponse;
import backend.sudurukbackx6.storeservice.domain.likes.entity.Likey;
import backend.sudurukbackx6.storeservice.domain.likes.repository.LikeRepository;
import backend.sudurukbackx6.storeservice.domain.store.entity.Store;
import backend.sudurukbackx6.storeservice.domain.store.repository.StoreRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Transactional
@RequiredArgsConstructor
public class LikeServiceImpl implements LikeService{

    private final LikeRepository likeRepository;
    private final StoreRepository storeRepository;

    // 찜 토글
    @Override
    public LikeToggleResponse toggleLike(Long memberId, Long storeId) {
        boolean exists = likeRepository.existsByMemberIdAndStoreId(memberId, storeId);

        Optional<Store> optionalStore = storeRepository.findById(storeId);

        Store store = optionalStore.get();

        if (exists) {
            // 이미 찜한 상태라면 찜 해제
            // TODO Exception 처리
            Likey existingLikey = likeRepository.findByMemberIdAndStoreId(memberId, storeId).orElseThrow(() -> new IllegalArgumentException("Like not found"));
            likeRepository.delete(existingLikey);

            LikeToggleResponse response = new LikeToggleResponse();
            response.setLiked(false);
            response.setStoreId(storeId);

            return response;

        } else {
            // 찜이 없다면 새로 찜 등록
            Likey likey = Likey.builder()
                    .memberId(memberId)
                    .store(store)
                    .build();
            likeRepository.save(likey);

            LikeToggleResponse response = new LikeToggleResponse();
            response.setLiked(true);
            response.setStoreId(storeId);

            return response;
        }
    }

    @Override
    public List<LikeResponse> getLikedStoresByMemberId(Long memberId) {
        List<Likey> likeys = likeRepository.findByMemberId(memberId);

        return likeys.stream()
                .map(likey -> {
                    return LikeResponse.builder()
                            .id(likey.getId())
                            .memberId(likey.getMemberId())
                            .storeId(likey.getStore().getId())
                            .cafeName(likey.getStore().getName())
                            .starPoint(likey.getStore().getStarPoint())
                            .reviewCount(likey.getStore().getReviews().size())
                            .img(likey.getStore().getImg())
                            .description(likey.getStore().getDescription())
                            .build();
                })
                .collect(Collectors.toList());
    }
}
