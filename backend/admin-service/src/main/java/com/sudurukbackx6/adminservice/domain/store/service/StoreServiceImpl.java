package com.sudurukbackx6.adminservice.domain.store.service;

import com.sudurukbackx6.adminservice.common.code.ErrorCode;
import com.sudurukbackx6.adminservice.common.exception.BadRequestException;
import com.sudurukbackx6.adminservice.domain.owner.dto.response.OwnerInfoResponse;
import com.sudurukbackx6.adminservice.domain.owner.entity.Business;
import com.sudurukbackx6.adminservice.domain.owner.entity.Owners;
import com.sudurukbackx6.adminservice.domain.owner.repository.OwnersRepository;
import com.sudurukbackx6.adminservice.domain.store.client.StoreGeocoding;
import com.sudurukbackx6.adminservice.domain.store.client.dto.GeocodingDto;
import com.sudurukbackx6.adminservice.domain.store.entity.Store;
import com.sudurukbackx6.adminservice.domain.store.repository.StoreRepository;
import com.sudurukbackx6.adminservice.domain.store.service.dto.StoreRequest;
import com.sudurukbackx6.adminservice.domain.store.service.dto.reponse.StoreInfoResDto;
import com.sudurukbackx6.adminservice.domain.store.service.dto.request.StoreUpdateReqDto;
import com.sudurukbackx6.adminservice.global.s3.S3Uploader;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.*;

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
    private final S3Uploader s3Uploader;
    private final StoreGeocoding storeGeocoding;
    private final OwnersRepository ownersRepository;

    @Value("${cloud.aws.cloud.url}")
    private String basicProfile;


    @Value("${ncp.clientId}")
    private String id;

    @Value("${ncp.secret}")
    private String secret;


    // 카페 등록
    @Override
    public void cafeSave(MultipartFile multipartFile, StoreRequest request, String email) throws IOException {
        Optional<Owners> optionalOwners = ownersRepository.findByEmail(email);

        if (optionalOwners.isPresent()) {
            Owners owner = optionalOwners.get();

            String upload = s3Uploader.upload(multipartFile, "StoreImages");
            GeocodingDto.Response response = getCoordinate(request.getAddress());

            log.info("주소 : {}", request.getAddress());

            String latitude = null;
            String longitude = null;

            // 좌표 추출
            if (!response.getAddresses().isEmpty()) {
                GeocodingDto.Response.Address firstAddress = response.getAddresses().get(0);
                longitude = firstAddress.getX();
                latitude = firstAddress.getY();
            } else {
                // 좌표가 없을 때 예외 처리
                throw new RuntimeException("좌표를 추출할 수 없습니다.");
            }

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
                    .owner(owner) // Owners 정보 설정
                    .build();

            storeRepository.saveAndFlush(store);
            // owner에 store 등록
            owner.changeStore(store);

        } else {
            throw new RuntimeException("해당 이메일을 가진 소유자를 찾을 수 없습니다.");
        }
    }

    @Override
    public void cafeImgChage(MultipartFile multipartFile, String email) throws IOException {
        Optional<Owners> optionalOwners = ownersRepository.findByEmail(email);
        Owners owner = optionalOwners.get();
        OwnerInfoResponse ownerInfo = OwnerInfoResponse.builder()
                .email(owner.getEmail())
                .tel(owner.getTel())
                .storeId(owner.getStore().getId())
                .build();
        Long cafeId = ownerInfo.getStoreId();
        Store store = storeRepository.findById(cafeId).orElseThrow();

        String upload = s3Uploader.upload(multipartFile, "StoreImages");
        store.setImg(upload);
    }

    @Override
    public void updateCafeInfo(String email, StoreUpdateReqDto storeUpdateReqDto, MultipartFile multipartFile) throws IOException {
        Optional<Owners> optionalOwners = ownersRepository.findByEmail(email);
        Owners owner = optionalOwners.get();
        OwnerInfoResponse ownerInfo = OwnerInfoResponse.builder()
                .email(owner.getEmail())
                .tel(owner.getTel())
                .storeId(owner.getStore().getId())
                .build();

        Long cafeId = ownerInfo.getStoreId();

        log.info("description : {}", storeUpdateReqDto.getDescription());
        System.out.println(storeUpdateReqDto.getDescription());

        if (multipartFile == null || multipartFile.isEmpty()) {
            Store store = storeRepository.findById(cafeId).orElseThrow();
            storeRepository.updateStoreInfo(storeUpdateReqDto.getDescription(), storeUpdateReqDto.getCloseTime(), storeUpdateReqDto.getOpenTime(), store.getImg(), cafeId);
            return;
        }
        String upload = s3Uploader.upload(multipartFile, "StoreImages");
        storeRepository.updateStoreInfo(storeUpdateReqDto.getDescription(), storeUpdateReqDto.getCloseTime(), storeUpdateReqDto.getOpenTime(), upload, cafeId);
    }

    @Override
    public StoreInfoResDto getStoreInfo(String email) {
        Owners owner = ownersRepository.findByEmail(email).orElseThrow(() -> new BadRequestException(ErrorCode.NOT_EXISTS_EMAIL));
        Store store = owner.getStore();

        return StoreInfoResDto.builder()
                .img(store.getImg())
                .tel(store.getTel())
                .description(store.getDescription())
                .openTime(store.getOpenTime())
                .closeTime(store.getCloseTime())
                .build();
    }

    @Override
    public Long initStore(Long ownerId) {
        Owners owner = ownersRepository.findById(ownerId).orElseThrow(() -> new BadRequestException(ErrorCode.NOT_EXISTS_OWNER));
        Business business = owner.getBusiness();
        GeocodingDto.Response response = getCoordinate(owner.getBusiness().getAddress());

        if (response.getAddresses().isEmpty()) {
            throw new BadRequestException(ErrorCode.NOT_EXISTS_ADDRESS);
        }


        GeocodingDto.Response.Address firstAddress = response.getAddresses().get(0);
        String longitude = firstAddress.getX();
        String latitude = firstAddress.getY();


        Store store = Store.builder().
                name(business.getName())
                .latitude(Double.valueOf(latitude))
                .longitude(Double.valueOf(longitude))
                .address(business.getAddress())
                .tel(business.getTel())
                .build();

        storeRepository.saveAndFlush(store);
        // owner에 store 등록
        owner.changeStore(store);
        return store.getId();
    }

    // 좌표변환
    private GeocodingDto.Response getCoordinate(String address) {
        return storeGeocoding.transferAddress(id, secret, address);
    }


}
