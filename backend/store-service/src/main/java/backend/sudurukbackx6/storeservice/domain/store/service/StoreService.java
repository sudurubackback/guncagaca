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
	List<NeerStoreResponse> cafeList(Long memberId, LocateRequest request);
	StoreResponse cafeDetail(Long memberId, Long cafeId);
	List<StoreMenuResponse> cafeMenu(Long memberId, Long cafeId);
	StoreMenuResponse cafeMenuDetail(Long memberId, Long cafeId, Long menuIndex);
	ShowStoreResponse cafeDescription(Long memberId, Long cafeId);
	List<StoreReviewResponse> cafeReview(Long memberId, Long cafeId);

}
