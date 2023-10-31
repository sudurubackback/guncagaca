package backend.sudurukbackx6.storeservice.domain.likes.service;

import backend.sudurukbackx6.storeservice.domain.store.entity.Store;

import java.util.List;

public interface LikeService {
    boolean toggleLike(Long memberId, Long storeId);

    List<Store>  getLikedStoresByMemberId(Long memberId);
}
