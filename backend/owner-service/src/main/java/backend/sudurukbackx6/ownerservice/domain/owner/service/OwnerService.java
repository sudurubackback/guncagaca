package backend.sudurukbackx6.ownerservice.domain.owner.service;

import backend.sudurukbackx6.ownerservice.domain.owner.dto.request.SignUpReqDto;

import java.io.IOException;

public interface OwnerService {

    //1. 회원가입
    void signUp(SignUpReqDto signUpReqDto) throws IOException;

    //2. 이메일로 인증 코드 전송
}
