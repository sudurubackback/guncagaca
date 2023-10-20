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

	@PostMapping("/{cafeId}/review/add")
	public void save(@PathVariable Long cafeId, @RequestBody ReviewSaveRequest request){
		reviewService.reviewSave(cafeId, request);
	}

	@DeleteMapping("/{cafeId}/review/delete/{reviewId}")
	public void delete(@PathVariable Long cafeId, @PathVariable Long reviewId){
		reviewService.reviewDelete(cafeId, reviewId);
	}
}
