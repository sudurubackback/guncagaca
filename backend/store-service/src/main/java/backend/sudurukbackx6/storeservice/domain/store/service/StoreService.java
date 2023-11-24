package backend.sudurukbackx6.storeservice.domain.store.service;

import java.io.IOException;
import java.util.List;

import backend.sudurukbackx6.storeservice.domain.store.entity.Store;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.LocateRequest;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.NeerStoreResponse;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.StoreRequest;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.StoreResponse;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.StoreReviewResponse;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.request.StoreUpdateReqDto;
import org.springframework.web.multipart.MultipartFile;

public interface StoreService {


    void cafeSave(MultipartFile multipartFile,StoreRequest request, String email) throws IOException;
    List<NeerStoreResponse> cafeList(Long memberId, LocateRequest request);
    StoreResponse cafeDetail(Long memberId, Long cafeId);
    List<StoreReviewResponse> cafeReview(Long cafeId);
    List<StoreReviewResponse> cafeReview(String email, Long cafeId);
    Store getCafe(Long cafeId);
    void updateStarPoint(Long storeId, Double point);
    void cafeImgChage(MultipartFile multipartFile, String email) throws IOException;
    void updateCafeInfo(String email, StoreUpdateReqDto storeUpdateReqDto, MultipartFile multipartFile) throws IOException;

}
