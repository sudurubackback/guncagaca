package backend.sudurukbackx6.storeservice.domain.store.controller;

import backend.sudurukbackx6.storeservice.domain.likes.dto.LikeToggleResponse;
import backend.sudurukbackx6.storeservice.domain.likes.service.LikeServiceImpl;
import backend.sudurukbackx6.storeservice.domain.reviews.client.MemberServiceClient;
import backend.sudurukbackx6.storeservice.domain.reviews.client.dto.MemberInfoResponse;
import backend.sudurukbackx6.storeservice.domain.store.entity.Store;
import backend.sudurukbackx6.storeservice.domain.store.service.StoreServiceImpl;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.*;
import io.swagger.v3.oas.annotations.Operation;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
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
    @PostMapping(value = "/save", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
    @Operation(summary = "카페 등록", description = "가게명, 주소, 전화번호, 이미지, 소개, 오픈시간, 마감시간을 입력받아 가게 등록\n등록 시 주소 통해서 자동으로 위도, 경도 입력됨", tags = { "Store Controller" })
    public void cafeSave(@RequestPart(value="file", required = false) MultipartFile file,@RequestPart StoreRequest request,@RequestHeader("Authorization") String token) throws IOException {
        storeService.cafeSave(file,request, token);
    }

    // 카페 이미지 변경
    @PutMapping(value = "/chageImg",consumes = {MediaType.MULTIPART_FORM_DATA_VALUE} )
    public void cafeImgChage(@RequestPart(value="file", required = false) MultipartFile multipartFile, @RequestHeader("Authorization") String token) throws IOException {
        storeService.cafeImgChage(multipartFile, token);
    }

    // 위도 경도 차이를 통해 0.0135가 1.5km 정도의 차이
    // 주변 카페 리스트
    @GetMapping("/list")
    @Operation(summary = "주변 카페 조회", description = "현재 위치의 위도, 경도 입력하면 주변 카페들을 거리순으로 반환", tags = { "Store Controller" })
    public List<NeerStoreResponse> cafeList(@RequestParam("lat") Double latitude, @RequestParam("lon") Double longitude){
        LocateRequest request = new LocateRequest();
        request.setLatitude(latitude);
        request.setLongitude(longitude);
        return storeService.cafeList(request);
    }

    // 카페 상세(소개)
    @GetMapping("/{cafeId}")
    @Operation(summary = "카페 정보 조회", description = "찜 여부 포함, 위도 경도 x 카페 정보 조회", tags = { "Store Controller" })
    public StoreResponse cafeDetail(@RequestHeader("Authorization") String token, @PathVariable Long cafeId){
        MemberInfoResponse memberInfo = memberServiceClient.getMemberInfo(token);
        // TODO token에서 memberId 추출해서 찜 여부 판단
        return storeService.cafeDetail(memberInfo.getId(), cafeId);
    }

    // 카페 리뷰 조회
    @GetMapping("/{cafeId}/review")
    @Operation(summary = "카페 리뷰 조회", description = "해당 카페의 리뷰 목록 조회", tags = { "Store Controller" })
    public List<StoreReviewResponse> cafeReview(@RequestHeader("Authorization") String token, @PathVariable Long cafeId){
        return storeService.cafeReview(token, cafeId);
    }

    // 찜 등록/해제
    @PostMapping("/{cafeId}/like")
    @Operation(summary = "찜 등록/해제", description = "해당 카페의 찜 등록을 토글 형식으로 변환", tags = { "Store Controller" })
    public LikeToggleResponse cafeLike(@RequestHeader("Authorization") String token, @PathVariable Long cafeId) {
        MemberInfoResponse memberInfo = memberServiceClient.getMemberInfo(token);

        return likeService.toggleLike(memberInfo.getId(), cafeId);

    }
}