package backend.sudurukbackx6.ownerservice.domain.business.controller;

import backend.sudurukbackx6.ownerservice.common.dto.BaseResponseBody;
import backend.sudurukbackx6.ownerservice.domain.business.dto.request.VendorVailidateReqDto;
import backend.sudurukbackx6.ownerservice.domain.business.service.BusinessService;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.request.SignUpReqDto;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/ceo")
public class BusinessController {
    private final BusinessService businessService;

    @Operation(summary = "사업자 인증", description = "사업자 인증이 완료 되면 회원 가입 완료 \n\n")
    @PostMapping("/cert")
    public ResponseEntity<? extends BaseResponseBody> signUp(@RequestBody VendorVailidateReqDto reqDto) throws IOException {
        boolean flag = businessService.checkBusinessValidation(reqDto);
        if (flag) {
            return ResponseEntity.status(HttpStatus.CREATED).body(new BaseResponseBody<>(200, "사업자 인증 성공"));
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new BaseResponseBody<>(400, "사업자 인증 실패"));
        }
    }


}
