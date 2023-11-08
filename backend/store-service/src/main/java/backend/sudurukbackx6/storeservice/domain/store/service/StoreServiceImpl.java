package backend.sudurukbackx6.storeservice.domain.store.service;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

import backend.sudurukbackx6.storeservice.domain.likes.repository.LikeRepository;
import backend.sudurukbackx6.storeservice.domain.reviews.client.MemberServiceClient;
import backend.sudurukbackx6.storeservice.domain.reviews.client.dto.MemberInfoResponse;
import backend.sudurukbackx6.storeservice.domain.reviews.entity.Review;
import backend.sudurukbackx6.storeservice.domain.reviews.repository.ReviewRepository;
import backend.sudurukbackx6.storeservice.domain.store.client.OwnerServiceClient;
import backend.sudurukbackx6.storeservice.domain.store.client.StoreGeocoding;
import backend.sudurukbackx6.storeservice.domain.store.client.dto.GeocodingDto;
import backend.sudurukbackx6.storeservice.domain.store.client.dto.OwnerInfoResponse;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.*;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.request.StoreUpdateReqDto;
import backend.sudurukbackx6.storeservice.global.s3.S3Uploader;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import backend.sudurukbackx6.storeservice.domain.store.entity.Store;
import backend.sudurukbackx6.storeservice.domain.store.repository.StoreRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.multipart.MultipartFile;

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
    private final S3Uploader s3Uploader;
    private final OwnerServiceClient ownerServiceClient;


    @Value("${cloud.aws.cloud.url}")
    private String basicProfile;


    @Value("${ncp.clientId}")
    private String id;

    @Value("${ncp.secret}")
    private String secret;

    // 카페 등록
    @Override
    public void cafeSave(MultipartFile multipartFile, StoreRequest request, String token) throws IOException {

        OwnerInfoResponse ownerInfo = ownerServiceClient.getOwnerInfo(token);

        String upload = s3Uploader.upload(multipartFile, "StoreImages");
        GeocodingDto.Response response = getCoordinate(request.getAddress());

        log.info("주소 : {}", request.getAddress());

        String latitude = null;
        String longitude = null;

        // 죄표 추출
        if (!response.getAddresses().isEmpty()) {
            GeocodingDto.Response.Address firstAddress = response.getAddresses().get(0);
            longitude = firstAddress.getX();
            latitude = firstAddress.getY();
        } // TODO : 좌표 없을 때 예외 처리
        log.info("위도 : {}", latitude);
        log.info("경도 : {}", longitude);

        Store store = Store.builder()
                .name(request.getStoreName())
                .latitude(Double.valueOf(latitude))
                .longitude(Double.valueOf(longitude))
                .address(request.getAddress())
                .tel(request.getTel())
                .img(upload)
                .openTime(request.getOpenTime())
                .closeTime(request.getCloseTime())
                .description(request.getDescription())
                .build();

        storeRepository.saveAndFlush(store);
        ChangeOwnerStoreIdRequest build = ChangeOwnerStoreIdRequest.builder()
                .email(ownerInfo.getEmail())
                .storeId(store.getId())
                .build();
        ownerServiceClient.changeOwnersStoreId(build);
    }

    @Override
    public void cafeImgChage(MultipartFile multipartFile, String token) throws IOException {
        OwnerInfoResponse ownerInfo = ownerServiceClient.getOwnerInfo(token);
        Long cafeId = ownerInfo.getStoreId();
        Store store = storeRepository.findById(cafeId).orElseThrow();

        String upload = s3Uploader.upload(multipartFile, "StoreImages");
        store.setImg(upload);
    }

    @Override
    public void updateCafeInfo(String token, StoreUpdateReqDto storeUpdateReqDto, MultipartFile multipartFile) throws IOException {
        OwnerInfoResponse ownerInfo = ownerServiceClient.getOwnerInfo(token);
        Long cafeId = ownerInfo.getStoreId();

        log.info("description : {}", storeUpdateReqDto.getDescription());
        System.out.println(storeUpdateReqDto.getDescription());

        if(multipartFile==null || multipartFile.isEmpty()) {
            Store store = storeRepository.findById(cafeId).orElseThrow();
            storeRepository.updateStoreInfo(storeUpdateReqDto.getDescription(), storeUpdateReqDto.getCloseTime(), storeUpdateReqDto.getOpenTime(), store.getImg(), cafeId);
            return;
        }
        String upload = s3Uploader.upload(multipartFile, "StoreImages");
        storeRepository.updateStoreInfo(storeUpdateReqDto.getDescription(), storeUpdateReqDto.getCloseTime(), storeUpdateReqDto.getOpenTime(), upload, cafeId);
    }


    // 주변 카페 리스트
    @Override
    public List<NeerStoreResponse> cafeList(Long memberId, LocateRequest request) {
        List<Store> allStores = storeRepository.findAll();
        List<NeerStoreResponse> nearCafes = new ArrayList<>();

        for (Store store : allStores) {

            // 거리 구하기
            double c = getLocate(request, store);
            double distance = EARTH_RADIUS * c;

            // 찜 여부
            boolean isLiked = likeRepository.existsByMemberIdAndStoreId(memberId, store.getId());

            if(distance > 0) {  // If distance is less than or equal to 1.5km
                StoreResponse storeResponse = new StoreResponse(store, isLiked);

                NeerStoreResponse cafe = new NeerStoreResponse(store.getLatitude(), store.getLongitude(),
                        distance, storeResponse);

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

    // 카페 검색
    @Override
    public List<NeerStoreResponse> searchCafe(Long memberId, String keyword, LocateRequest locateRequest) {
        List<Store> stores = storeRepository.findByNameContaining(keyword);
        List<NeerStoreResponse> nearCafes = new ArrayList<>();

        if (!stores.isEmpty()) {
            for (Store store : stores) {
                // 거리 구하기
                double c = getLocate(locateRequest, store);
                double distance = EARTH_RADIUS * c;

                // 찜 여부
                boolean isLiked = likeRepository.existsByMemberIdAndStoreId(memberId, store.getId());

                StoreResponse storeResponse = new StoreResponse(store, isLiked);

                NeerStoreResponse cafe = new NeerStoreResponse(store.getLatitude(), store.getLongitude(),
                        distance, storeResponse);

                nearCafes.add(cafe);
            }
        }
        return nearCafes;
    }

    // 카페 기본 정보
    @Override
    public StoreResponse cafeDetail(Long memberId, Long cafeId) {

        // 찜 여부
        boolean isLiked = likeRepository.existsByMemberIdAndStoreId(memberId, cafeId);
        Store store = getCafe(cafeId);

        return new StoreResponse(store, isLiked);
    }

    @Override
    public List<StoreReviewResponse> cafeReview(Long cafeId) {
        return null;
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

        int reviewCount = store.getReviews().size();
        Double totalPoint = (reviewCount-1) * store.getStarPoint(); // 총점 (방금 작성한 리뷰는 카운트 x)

        Double newStarPoint = (totalPoint + point) / reviewCount;
        storeRepository.updateStarPoint(newStarPoint, storeId);
    }

    @Override
    public Store getCafe(Long cafeId) {
        return storeRepository.findById(cafeId).orElseThrow();
    }

}
