package backend.sudurukbackx6.ownerservice.domain.owner.service;

import backend.sudurukbackx6.ownerservice.domain.owner.dto.SetStoreIdFromOwnerRequest;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.OwnerInfoResponse;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.request.SignInReqDto;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.request.SignUpReqDto;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.request.UpdatePwReqDto;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.response.SignInResDto;
import backend.sudurukbackx6.ownerservice.domain.owner.entity.Owners;

import javax.mail.MessagingException;
import java.io.IOException;

public interface OwnerService {

    //1. 로그인 & 로그아웃
    SignInResDto signIn(SignInReqDto request);
    void signOut(String header);

    //2. accesstoen 갱신
    SignInResDto refreshAccessToken(String header);

//    Owners findByEmail(String email);

    // 이메일 받아서 owner 받아오기
    OwnerInfoResponse ownerInfo (String token);

    Long ownerStoreId (SetStoreIdFromOwnerRequest request);
//    void toggleValidStatus(String email);
}
