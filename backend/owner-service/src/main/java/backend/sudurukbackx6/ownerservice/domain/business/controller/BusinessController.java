package backend.sudurukbackx6.ownerservice.domain.business.controller;

import backend.sudurukbackx6.ownerservice.common.dto.BaseResponseBody;
import backend.sudurukbackx6.ownerservice.domain.business.dto.request.VendorValidateReqDto;
import backend.sudurukbackx6.ownerservice.domain.business.dto.response.VendorValidateResDto;
import backend.sudurukbackx6.ownerservice.domain.business.service.BusinessService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.net.URISyntaxException;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/owner")
public class BusinessController {
    private final BusinessService businessService;

    @Operation(summary = "사업자 인증", description = "사업자 인증을 한 후에 회원가입이 가능하다. 반환된 값은 회원 가입시 사용된다. \n\n")
    @ApiResponses({
            @ApiResponse(
                    responseCode = "200",
                    description = "OK",
                    content = @Content(
                            mediaType = "application/json",
                            schema = @Schema(implementation = VendorValidateResDto.class),
                            examples = @ExampleObject(
                                    value = "{\n"
                                            + "  \"status\": 200,\n"
                                            + "  \"message\": \"사업자 인증 성공\",\n"
                                            + "  \"data\": {\n"
                                            + "    \"business_id\": \"business_id\"\n"
                                            + "  }\n"
                                            + "}"
                            )
                    )
            )
    })
    @PostMapping("/cert")
    public ResponseEntity<? extends BaseResponseBody> checkCert(@RequestBody VendorValidateReqDto reqDto) throws IOException, URISyntaxException {
        long flag = businessService.checkBusinessValidation(reqDto);
        VendorValidateResDto result = new VendorValidateResDto(flag);
        if (flag>0) {
            return ResponseEntity.status(HttpStatus.CREATED).body(new BaseResponseBody<>(200, "사업자 인증 성공", result));
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new BaseResponseBody<>(400, "사업자 인증 실패"));
        }
    }


}
