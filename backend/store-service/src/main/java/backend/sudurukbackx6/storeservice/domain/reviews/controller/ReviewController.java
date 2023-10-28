package backend.sudurukbackx6.storeservice.domain.reviews.controller;

import org.springframework.web.bind.annotation.*;

import backend.sudurukbackx6.storeservice.domain.reviews.service.ReviewServiceImpl;
import backend.sudurukbackx6.storeservice.domain.reviews.service.dto.ReviewSaveRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/cafe")
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewServiceImpl reviewService;

    @PostMapping("/{cafe_id}/review/add")
    public void save(@RequestHeader("Authorization") String token, @PathVariable Long cafe_id, @RequestBody ReviewSaveRequest request){
        log.info("token = {}", token);
        reviewService.reviewSave(token, cafe_id, request);
    }

    @DeleteMapping("/{cafe_id}/review/delete/{review_id}/{member_id}")
    public void delete(@RequestHeader("Authorization") String token, @PathVariable Long cafe_id, @PathVariable Long review_id){
        reviewService.reviewDelete(token, cafe_id, review_id);
    }
}
