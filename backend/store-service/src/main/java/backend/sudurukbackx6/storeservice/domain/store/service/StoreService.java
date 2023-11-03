package backend.sudurukbackx6.storeservice.domain.store.service;

import java.io.IOException;
import java.util.List;

import backend.sudurukbackx6.storeservice.domain.store.entity.Store;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.LocateRequest;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.NeerStoreResponse;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.ShowStoreResponse;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.StoreMenuResponse;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.StoreRequest;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.StoreResponse;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.StoreReviewResponse;
import org.springframework.web.multipart.MultipartFile;

public interface StoreService {

    void cafeSave(MultipartFile multipartFile,StoreRequest request, String token) throws IOException;
    List<NeerStoreResponse> cafeList(LocateRequest request);
    StoreResponse cafeDetail(Long memberId, Long cafeId);
    List<StoreReviewResponse> cafeReview(Long cafeId);
//    List<StoreMenuResponse> cafeMenu(String token, Long cafeId);
//    StoreMenuResponse cafeMenuDetail(String token, Long cafeId, Long menuIndex);
    List<StoreReviewResponse> cafeReview(String token, Long cafeId);
    Store getCafe(Long cafeId);
    void updateStarPoint(Long storeId, Double point);
    void cafeImgChage(MultipartFile multipartFile, String token) throws IOException;
}
