package com.sudurukbackx6.adminservice.domain.owner.controller;

import com.sudurukbackx6.adminservice.common.dto.BaseResponseBody;
import com.sudurukbackx6.adminservice.domain.owner.dto.request.BusinessValidReqDto;
import com.sudurukbackx6.adminservice.domain.owner.dto.response.BusinessValidResDto;
import com.sudurukbackx6.adminservice.domain.owner.service.BusinessService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.net.URISyntaxException;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/ceo")
public class BusinessController {
    private final BusinessService businessService;

    @Operation(summary = "사업자 인증", description = "사업자 인증을 한 후에 회원가입이 가능하다. 반환된 값은 회원 가입시 사용된다. \n\n")
    @ApiResponses({
            @ApiResponse(
                    responseCode = "200",
                    description = "OK",
                    content = @Content(
                            mediaType = "application/json",
                            schema = @Schema(implementation = BusinessValidResDto.class),
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
    @PostMapping(value = "/cert", consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE})
    public ResponseEntity<? extends BaseResponseBody> checkCert(@RequestPart BusinessValidReqDto reqDto, @RequestPart(value = "file", required = false) MultipartFile multipartFile) throws IOException, URISyntaxException {
        long flag = businessService.checkBusinessValidation(reqDto, multipartFile);
        BusinessValidResDto result = new BusinessValidResDto(flag);
        if (flag>0) {
            return ResponseEntity.status(HttpStatus.CREATED).body(new BaseResponseBody<>(200, "사업자 인증 성공", result));
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new BaseResponseBody<>(400, "사업자 인증 실패"));
        }
    }


}
