package backend.sudurukbackx6.storeservice.domain.reviews.controller;

import backend.sudurukbackx6.storeservice.domain.reviews.client.MemberServiceClient;
import backend.sudurukbackx6.storeservice.domain.reviews.client.dto.MemberInfoResponse;
import backend.sudurukbackx6.storeservice.domain.reviews.entity.Review;
import backend.sudurukbackx6.storeservice.domain.reviews.service.dto.MyReviewResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import backend.sudurukbackx6.storeservice.domain.reviews.service.ReviewServiceImpl;
import backend.sudurukbackx6.storeservice.domain.reviews.service.dto.ReviewDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/store")
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewServiceImpl reviewService;
    private final MemberServiceClient memberServiceClient;

    // 리뷰 등록
    @PostMapping("/{cafeId}/{orderId}/review")
    public ReviewDto.Response saveReview(@RequestHeader("Authorization") String token, @PathVariable Long cafeId,
                                         @PathVariable Long orderId, @RequestBody ReviewDto.Request request){
        log.info("token = {}", token);
        return reviewService.reviewSave(token, cafeId, orderId, request);
    }

    // 리뷰 삭제
    @DeleteMapping("/{cafeId}/{reviewId}/review")
    public ResponseEntity<String> deleteReview(@RequestHeader("Authorization") String token, @PathVariable Long cafeId, @PathVariable Long reviewId){
        reviewService.reviewDelete(token, cafeId, reviewId);
        return ResponseEntity.ok(String.format("%d번 리뷰 삭제", reviewId));
    }

    // 멤버가 리뷰한 목록 조회
    @GetMapping("/mypage/reviews")
    public ResponseEntity<List<MyReviewResponse>> LikedStoresByMemberId(@RequestHeader("Authorization") String token, @PathVariable Long memberId){
        MemberInfoResponse memberInfo = memberServiceClient.getMemberInfo(token);
        return ResponseEntity.ok(reviewService.getReviewByMemberId(memberInfo.getId()));

    }
}
