package com.sudurukbackx6.adminservice.domain.store.service;

import com.sudurukbackx6.adminservice.domain.store.entity.Store;
import com.sudurukbackx6.adminservice.domain.store.service.dto.StoreRequest;
import com.sudurukbackx6.adminservice.domain.store.service.dto.reponse.StoreInfoResDto;
import com.sudurukbackx6.adminservice.domain.store.service.dto.request.StoreUpdateReqDto;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface StoreService {

    //admin
    void cafeSave(MultipartFile multipartFile, StoreRequest request, String email) throws IOException;
    void cafeImgChage(MultipartFile multipartFile, String email) throws IOException;
    void updateCafeInfo(String email, StoreUpdateReqDto storeUpdateReqDto, MultipartFile multipartFile) throws IOException;
    StoreInfoResDto getStoreInfo(String email);
    Long initStore(Long ownerId);
}
