package com.sudurukbackx6.adminservice.common.exception;

import com.sudurukbackx6.adminservice.common.code.ErrorCode;
import lombok.Getter;

@Getter
public class BadRequestException extends RuntimeException {

    private ErrorCode errorCode;

    public BadRequestException(ErrorCode errorCode) {
        super(errorCode.getMessage());
        this.errorCode = errorCode;
    }
}