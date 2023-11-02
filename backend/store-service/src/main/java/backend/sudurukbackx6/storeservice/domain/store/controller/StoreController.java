package backend.sudurukbackx6.storeservice.domain.store.controller;

import backend.sudurukbackx6.storeservice.domain.likes.dto.LikeToggleResponse;
import backend.sudurukbackx6.storeservice.domain.likes.service.LikeServiceImpl;
import backend.sudurukbackx6.storeservice.domain.reviews.client.MemberServiceClient;
import backend.sudurukbackx6.storeservice.domain.reviews.client.dto.MemberInfoResponse;
import backend.sudurukbackx6.storeservice.domain.store.service.StoreServiceImpl;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.*;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/store")
@RequiredArgsConstructor
public class StoreController {

    private final StoreServiceImpl storeService;
    private final LikeServiceImpl likeService;
    private final MemberServiceClient memberServiceClient;


    // 카페 등록
    @PostMapping("/save")
    public void cafeSave(@RequestBody StoreRequest request){
        storeService.cafeSave(request);
    }

    // 위도 경도 차이를 통해 0.0135가 1.5km 정도의 차이
    // 주변 카페 리스트
    @GetMapping("/list")
    public List<NeerStoreResponse> cafeList(@RequestParam("lat") Double latitude, @RequestParam("lon") Double longitude){
        LocateRequest request = new LocateRequest();
        request.setLatitude(latitude);
        request.setLongitude(longitude);
        return storeService.cafeList(request);
    }

    // 카페 상세(소개)
    @GetMapping("/{cafeId}")
    public StoreResponse cafeDetail(@RequestHeader("Authorization") String token, @PathVariable Long cafeId){
        MemberInfoResponse memberInfo = memberServiceClient.getMemberInfo(token);
        // TODO token에서 memberId 추출해서 찜 여부 판단
        return storeService.cafeDetail(memberInfo.getId(), cafeId);
    }

    // 카페 리뷰 조회
    @GetMapping("/{cafeId}/review")
    public List<StoreReviewResponse> cafeReview(@PathVariable Long cafeId){
        return storeService.cafeReview(cafeId);
    }

    // 찜 등록/해제
    @PostMapping("/{cafeId}/like")
    public LikeToggleResponse cafeLike(@RequestHeader("Authorization") String token, @PathVariable Long cafeId) {
        MemberInfoResponse memberInfo = memberServiceClient.getMemberInfo(token);

        return likeService.toggleLike(memberInfo.getId(), cafeId);

    }
}