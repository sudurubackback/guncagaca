package backend.sudurukbackx6.storeservice.domain.reviews.controller;

import backend.sudurukbackx6.storeservice.domain.reviews.client.MemberServiceClient;
import backend.sudurukbackx6.storeservice.domain.reviews.client.dto.MemberInfoResponse;
import backend.sudurukbackx6.storeservice.domain.reviews.entity.Review;
import backend.sudurukbackx6.storeservice.domain.reviews.service.dto.MyReviewResponse;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import backend.sudurukbackx6.storeservice.domain.reviews.service.ReviewServiceImpl;
import backend.sudurukbackx6.storeservice.domain.reviews.service.dto.ReviewDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/cafe")
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewServiceImpl reviewService;
    private final MemberServiceClient memberServiceClient;

    // 리뷰 등록
    @PostMapping("/{cafeId}/{orderId}/review")
    @Operation(summary = "리뷰 등록", description = "주문완료건에 대해 리뷰 작성", tags = { "Review Controller" })
    public ReviewDto.Response saveReview(@RequestHeader("Email") String email, @PathVariable Long cafeId,
                                         @PathVariable String orderId, @RequestBody ReviewDto.Request request){

        return reviewService.reviewSave(email, cafeId, orderId, request);
    }

    // 리뷰 삭제
    @DeleteMapping("/{cafeId}/{reviewId}/review")
    @Operation(summary = "리뷰 삭제", description = "내가 쓴 리뷰 삭제", tags = { "Review Controller" })
    public ResponseEntity<String> deleteReview(@RequestHeader("Email") String email, @PathVariable Long cafeId, @PathVariable Long reviewId){
        reviewService.reviewDelete(email, cafeId, reviewId);
        return ResponseEntity.ok(String.format("%d번 리뷰 삭제", reviewId));
    }

    // 멤버가 리뷰한 목록 조회
    @GetMapping("/mypage/reviews")
    @Operation(summary = "리뷰 조회", description = "내가 쓴 리뷰 목록 조회", tags = { "Review Controller" })
    public ResponseEntity<List<MyReviewResponse>> LikedStoresByMemberId(@RequestHeader("Email") String email){
        MemberInfoResponse memberInfo = memberServiceClient.getMemberInfo(email);
        return ResponseEntity.ok(reviewService.getReviewByMemberId(memberInfo.getId()));

    }
}
