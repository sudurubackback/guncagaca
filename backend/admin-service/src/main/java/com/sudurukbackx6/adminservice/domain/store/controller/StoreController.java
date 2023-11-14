package com.sudurukbackx6.adminservice.domain.store.controller;


import com.sudurukbackx6.adminservice.common.dto.BaseResponseBody;
import com.sudurukbackx6.adminservice.domain.store.service.StoreService;
import com.sudurukbackx6.adminservice.domain.store.service.StoreServiceImpl;
import com.sudurukbackx6.adminservice.domain.store.service.dto.StoreRequest;
import com.sudurukbackx6.adminservice.domain.store.service.dto.request.StoreUpdateReqDto;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/cafe")
@RequiredArgsConstructor
public class StoreController {

    private final StoreService storeService;

    // 카페 등록 //admin
    @PostMapping(value = "/save", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
    @Operation(summary = "카페 등록", description = "가게명, 주소, 전화번호, 이미지, 소개, 오픈시간, 마감시간을 입력받아 가게 등록\n등록 시 주소 통해서 자동으로 위도, 경도 입력됨", tags = { "Store Controller" })
    public ResponseEntity<? extends BaseResponseBody> cafeSave(@RequestPart(value="file", required = false) MultipartFile file, @ModelAttribute StoreRequest request, @RequestHeader("Email") String email) throws IOException {
        storeService.cafeSave(file,request, email);
        return ResponseEntity.status(200).body(new BaseResponseBody(200, "카페 등록 성공"));
    }

    // 카페 이미지 변경 //admin
    @PutMapping(value = "/chageImg",consumes = {MediaType.MULTIPART_FORM_DATA_VALUE} )
    public void cafeImgChage(@RequestPart(value="file", required = false) MultipartFile multipartFile, @RequestHeader("Email") String email) throws IOException {
        storeService.cafeImgChage(multipartFile, email);
    }
    
    //카페 정보 수정 //admin
    @PutMapping(value = "/info",consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE})
    @Operation(summary = "카페 정보 수정", description = "tel, description, openTime, closeTime, file 필요", tags = { "Store Controller" })
    public ResponseEntity<? extends BaseResponseBody> updateCafeInfo(@RequestPart(value="file", required = false) MultipartFile multipartFile, @RequestHeader("Email") String email, @RequestPart StoreUpdateReqDto reqDto) throws IOException {
        storeService.updateCafeInfo(email, reqDto, multipartFile);
        return ResponseEntity.status(200).body(new BaseResponseBody(200, "카페 정보 수정 성공"));
    }

    // 카페 정보 조회
    @GetMapping(value = "/info")
    @Operation(summary = "카페 정보 조회", description = "카페 정보 조회", tags = { "Store Controller" })
    public ResponseEntity<? extends BaseResponseBody> getStoreInfo(@RequestHeader("Email") String email) {
        return ResponseEntity.status(200).body(new BaseResponseBody(200, "카페 정보 조회 성공", storeService.getStoreInfo(email)));
    }


}