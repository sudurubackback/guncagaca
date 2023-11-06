package backend.sudurukbackx6.storeservice.domain.likes.service;

import backend.sudurukbackx6.storeservice.domain.likes.dto.LikeResponse;
import backend.sudurukbackx6.storeservice.domain.likes.dto.LikeToggleResponse;
import backend.sudurukbackx6.storeservice.domain.store.entity.Store;

import java.util.List;

public interface LikeService {
    LikeToggleResponse toggleLike(Long memberId, Long storeId);

    List<LikeResponse>  getLikedStoresByMemberId(Long memberId);
}
