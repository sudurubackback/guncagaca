package com.sudurukbackx6.adminservice.common.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@Builder
@AllArgsConstructor
@RequiredArgsConstructor
public class ErrorResponse {
    private String httpStatus;
    private int errorCode;
    private String errorMessage;

    public static ErrorResponse of(String httpStatus, int errorCode, String errorMessage) {
        return ErrorResponse.builder()
                .httpStatus(httpStatus)
                .errorCode(errorCode)
                .errorMessage(errorMessage)
                .build();
    }
}