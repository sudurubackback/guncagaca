package backend.sudurukbackx6.storeservice.domain.store.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import backend.sudurukbackx6.storeservice.domain.reviews.entity.Review;
import backend.sudurukbackx6.storeservice.domain.reviews.repository.ReviewRepository;
import backend.sudurukbackx6.storeservice.domain.store.entity.Store;
import backend.sudurukbackx6.storeservice.domain.store.repository.StoreRepository;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.LocateRequest;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.NeerStoreResponse;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.ShowStoreResponse;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.StoreMenuResponse;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.StoreRequest;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.StoreResponse;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.StoreReviewResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class StoreServiceImpl implements StoreService {


	private final StoreRepository storeRepository;
	private final ReviewRepository reviewRepository;

	@Override
	public void cafeSave(StoreRequest request) {

		Store store = Store.builder()
			.name(request.getStoreName())
			.latitude(request.getLatitude())
			.longitude(request.getLongitude())
			.address(request.getAddress())
			.tel(request.getTel())
			.img(request.getImg())
			.description(request.getDescription())
			.build();

		storeRepository.save(store);
	}

	@Override
	public List<NeerStoreResponse> cafeList(Long memberId, LocateRequest request) {
		return null;
	}

	@Override
	public StoreResponse cafeDetail(Long memberId, Long cafeId) {
		Result result = getResult(cafeId);

		return StoreResponse.builder()
			.cafeName(result.store.getName())
			.starTotal(result.star_adding)
			.reviewCount(result.reviewList.size())
			.img(result.store.getImg())
			.build();
	}

	@Override
	public List<StoreMenuResponse> cafeMenu(Long memberId, Long cafeId) {

		return null;
	}

	@Override
	public StoreMenuResponse cafeMenuDetail(Long memberId, Long cafeId, Long menuIndex) {
		return null;
	}

	@Override
	public ShowStoreResponse cafeDescription(Long memberId, Long cafeId) {
		Result result = getResult(cafeId);

		return null;
	}


	@Override
	public List<StoreReviewResponse> cafeReview(Long memberId, Long cafeId) {
		Result result = getResult(cafeId);

		List<StoreReviewResponse> reviewResponses = new ArrayList<>();

		List<Review> reviewList = result.reviewList;
		for (Review review : reviewList) {
			StoreReviewResponse build = StoreReviewResponse.builder()
				.star(review.getStar())
				.content(review.getComment())
				.build();

			reviewResponses.add(build);
		}

		return reviewResponses;
	}



	private Result getResult(Long cafeId) {
		Store store = storeRepository.findById(cafeId).orElseThrow(RuntimeException::new);

		List<Review> reviewList = store.getReview();

		double star_adding = 0;

		for (Review review : reviewList) {
			int star = review.getStar();
			star_adding += star;
		}
		star_adding /= reviewList.size();
		Result result = new Result(store, reviewList, star_adding);
		return result;
	}

	private static class Result {
		public final Store store;
		public final List<Review> reviewList;
		public final double star_adding;

		public Result(Store store, List<Review> reviewList, double star_adding) {
			this.store = store;
			this.reviewList = reviewList;
			this.star_adding = star_adding;
		}
	}
}
