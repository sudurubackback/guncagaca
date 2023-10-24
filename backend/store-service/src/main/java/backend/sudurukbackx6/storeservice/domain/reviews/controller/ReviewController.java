package backend.sudurukbackx6.storeservice.domain.reviews.controller;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
    public void save(@PathVariable Long cafe_id, @RequestBody ReviewSaveRequest request){
        reviewService.reviewSave(cafe_id, request);
    }

    @DeleteMapping("/{cafe_id}/review/delete/{review_id}")
    public void delete(@PathVariable Long cafe_id, @PathVariable Long review_id){
        reviewService.reviewDelete(cafe_id, review_id);
    }
}
