package backend.sudurukbackx6.storeservice.domain.store.service;

import java.util.List;

import backend.sudurukbackx6.storeservice.domain.store.service.dto.LocateRequest;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.NeerStoreResponse;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.ShowStoreResponse;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.StoreMenuResponse;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.StoreRequest;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.StoreResponse;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.StoreReviewResponse;

public interface StoreService {

    void cafeSave(StoreRequest request);
    List<NeerStoreResponse> cafeList(LocateRequest request);
    StoreResponse cafeDetail(Long cafeId);
    List<StoreMenuResponse> cafeMenu(String token, Long cafeId);
    StoreMenuResponse cafeMenuDetail(String token, Long cafeId, Long menuIndex);
    // ShowStoreResponse cafeDescription(Long memberId, Long cafeId);
    List<StoreReviewResponse> cafeReview(String token, Long cafeId);

}
