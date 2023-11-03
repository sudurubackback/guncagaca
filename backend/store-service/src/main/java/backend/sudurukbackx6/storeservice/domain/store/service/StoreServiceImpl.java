package backend.sudurukbackx6.storeservice.domain.store.service;

import java.util.*;
import java.util.stream.Collectors;

import backend.sudurukbackx6.storeservice.domain.likes.repository.LikeRepository;
import backend.sudurukbackx6.storeservice.domain.reviews.client.MemberServiceClient;
import backend.sudurukbackx6.storeservice.domain.reviews.client.dto.MemberInfoResponse;
import backend.sudurukbackx6.storeservice.domain.reviews.entity.Review;
import backend.sudurukbackx6.storeservice.domain.reviews.repository.ReviewRepository;
import backend.sudurukbackx6.storeservice.domain.store.client.StoreGeocoding;
import backend.sudurukbackx6.storeservice.domain.store.client.dto.GeocodingDto;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import backend.sudurukbackx6.storeservice.domain.store.entity.Store;
import backend.sudurukbackx6.storeservice.domain.store.repository.StoreRepository;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.LocateRequest;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.NeerStoreResponse;
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

    /**
     * 메뉴 부분 기능 개발
     * API 호출
     * 인가를 어떻게 할지 -> 인가를 통해서 Bearer 처리를 하고, 이 다음 service 메서드를 진행한다.
     */

    private static final double EARTH_RADIUS = 6371.0;
    private final StoreRepository storeRepository;
    private final ReviewRepository reviewRepository;
    private final LikeRepository likeRepository;
    private final StoreGeocoding storeGeocoding;
    private final MemberServiceClient memberServiceClient;

    @Value("${ncp.clientId}")
    private String id;

    @Value("${ncp.secret}")
    private String secret;

    // 카페 등록
    @Override
    public void cafeSave(StoreRequest request) {

        GeocodingDto.Response response = getCoordinate(request.getAddress());

        String latitude = null;
        String longitude = null;

        // 죄표 추출
        if (!response.getAddresses().isEmpty()) {
            GeocodingDto.Response.Address firstAddress = response.getAddresses().get(0);
            latitude = firstAddress.getX();
            longitude = firstAddress.getY();
        } // TODO : 좌표 없을 때 예외 처리
        log.info("위도 : {}", latitude);
        log.info("경도 : {}", longitude);

        Store store = Store.builder()
                .name(request.getStoreName())
                .latitude(Double.valueOf(latitude))
                .longitude(Double.valueOf(longitude))
                .address(request.getAddress())
                .tel(request.getTel())
                .img(request.getImg())
                .openTime(request.getOpenTime())
                .closeTime(request.getCloseTime())
                .description(request.getDescription())
                .build();

        storeRepository.save(store);
    }

    // 주변 카페 리스트
    @Override
    public List<NeerStoreResponse> cafeList(LocateRequest request) {
        List<Store> allStores = storeRepository.findAll();
        List<NeerStoreResponse> nearCafes = new ArrayList<>();

        for (Store store : allStores) {

            // 거리 구하기
            double c = getLocate(request, store);
            double distance = EARTH_RADIUS * c;


            if(distance > 0) {  // If distance is less than or equal to 1.5km
                NeerStoreResponse cafe = NeerStoreResponse.builder()
                        .storeId(store.getId())
                    .cafeName(store.getName())
                    .latitude(store.getLatitude())
                    .longitude(store.getLongitude())
                    .starTotal(store.getStarPoint())
                    .reviewCount(store.getReview().size())
                    .img(store.getImg())
                    .distance(distance)
                        .address(store.getAddress())
                    .build();

                nearCafes.add(cafe);
            }
        }

        // 거리 기준 오름차순 정렬
        List<NeerStoreResponse> sortedCafes = nearCafes.stream()
                .sorted(Comparator.comparingDouble(NeerStoreResponse::getDistance))
                .collect(Collectors.toList());

        return sortedCafes;
    }

    // 현재위치와 카페 사이 거리
    private static double getLocate(LocateRequest request, Store store) {
        double dLat = Math.toRadians(request.getLatitude() - store.getLatitude());
        double dLon = Math.toRadians(request.getLongitude() - store.getLongitude());

        double lat1 = Math.toRadians(request.getLatitude());
        double lat2 = Math.toRadians(store.getLatitude());

        double a = Math.pow(Math.sin(dLat / 2), 2)
            + Math.cos(lat1) * Math.cos(lat2) * Math.pow(Math.sin(dLon / 2), 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return c;
    }

    // 카페 기본 정보
    @Override
    public StoreResponse cafeDetail(Long memberId, Long cafeId) {

        // 찜 여부
        boolean isLiked = likeRepository.existsByMemberIdAndStoreId(memberId, cafeId);
        Store store = getCafe(cafeId);

        return StoreResponse.builder()
                .storeId(cafeId)
                .cafeName(store.getName())
                .starPoint(store.getStarPoint())
                .reviewCount(store.getReview().size())
                .img(store.getImg())
                .isLiked(isLiked)
                .description(store.getDescription())
                .build();
    }

    // 리뷰 최신순
    @Override
    public List<StoreReviewResponse> cafeReview(String token, Long cafeId) {

        List<Review> reviewList = reviewRepository.findByStoreIdOrderByIdDesc(cafeId);
        // 리뷰의 멤버Id 목록
        Set<Long> memberIds = reviewList.stream().map(Review::getMemberId).collect(Collectors.toSet());
        List<Long> memberIdsList = new ArrayList<>(memberIds);
        List<MemberInfoResponse> memberInfoList = memberServiceClient.getMemberInfo(token, memberIdsList);

        // Id : 닉네임
        Map<Long, String> memberIdToNicknameMap = memberInfoList.stream()
                .collect(Collectors.toMap(MemberInfoResponse::getId, MemberInfoResponse::getNickname));

        List<StoreReviewResponse> storeReviewResponses = reviewList.stream().map(review -> {
            String nickname = memberIdToNicknameMap.getOrDefault(review.getMemberId(), "Unknown");
            return StoreReviewResponse.builder()
                    .reviewId(review.getId())
                    .nickname(nickname)
                    .star(review.getStar())
                    .content(review.getComment())
                    .build();
        }).collect(Collectors.toList());

        return storeReviewResponses;

    }

    // 좌표변환
    private GeocodingDto.Response getCoordinate(String address) {
        return storeGeocoding.transferAddress(id, secret, address);
    }

    // 별점 업데이트
    @Override
    public void updateStarPoint(Long storeId, Double point) {
        Store store = getCafe(storeId);

        int reviewCount = store.getReview().size();
        Double totalPoint = (reviewCount-1) * store.getStarPoint(); // 총점 (방금 작성한 리뷰는 카운트 x)

        Double newStarPoint = (totalPoint + point) / reviewCount;
        storeRepository.updateStarPoint(newStarPoint, storeId);
    }

    @Override
    public Store getCafe(Long cafeId) {
        return storeRepository.findById(cafeId).orElseThrow();
    }

}
