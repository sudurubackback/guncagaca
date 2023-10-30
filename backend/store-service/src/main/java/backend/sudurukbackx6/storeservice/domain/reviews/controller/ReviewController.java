package backend.sudurukbackx6.storeservice.domain.reviews.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import backend.sudurukbackx6.storeservice.domain.reviews.service.ReviewServiceImpl;
import backend.sudurukbackx6.storeservice.domain.reviews.service.dto.ReviewDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/review")
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewServiceImpl reviewService;

    // 리뷰 등록
    @PostMapping("/{cafeId}/{orderId}")
    public ReviewDto.Response saveReview(@RequestHeader("Authorization") String token, @PathVariable Long cafeId,
                                         @PathVariable Long orderId, @RequestBody ReviewDto.Request request){
        log.info("token = {}", token);
        return reviewService.reviewSave(token, cafeId, orderId, request);
    }

    // 리뷰 삭제
    @DeleteMapping("/{cafeId}/{reviewId}")
    public ResponseEntity<String> deleteReview(@RequestHeader("Authorization") String token, @PathVariable Long cafeId, @PathVariable Long reviewId){
        reviewService.reviewDelete(token, cafeId, reviewId);
        return ResponseEntity.ok(String.format("%d번 리뷰 삭제", reviewId));
    }
}
