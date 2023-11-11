package com.sudurukbackx6.adminservice.common.code;

import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public enum ErrorCode {

    NOT_VALID_TOKEN(HttpStatus.UNAUTHORIZED, 401, "해당 토큰은 유효한 토큰이 아닙니다."),
    NOT_EXISTS_AUTHORIZATION(HttpStatus.UNAUTHORIZED, 401, "Authorization Header가 빈 값입니다."),
    INVALID_REQUEST(HttpStatus.BAD_REQUEST, 400, "요청이 올바르지 않습니다."),

    NOT_MATCH(HttpStatus.BAD_REQUEST, 400, "이메일 또는 비밀번호가 일치하지 않습니다."),
    DUPLICATED_EMAIL(HttpStatus.BAD_REQUEST, 400, "이미 존재하는 이메일입니다."),
    NOT_EXISTS_EMAIL(HttpStatus.BAD_REQUEST, 400, "존재하지 않는 이메일입니다."),

    FAIL_SENDMAIL(HttpStatus.BAD_REQUEST, 400, "이메일 전송에 실패하였습니다."),
    DONT_MATCH_CODE(HttpStatus.BAD_REQUEST, 400, "인증코드가 일치하지 않습니다.");

    private HttpStatus httpStatus;
    private int errorCode;
    private String message;

    ErrorCode(HttpStatus httpStatus, int errorCode, String message) {
        this.httpStatus = httpStatus;
        this.errorCode = errorCode;
        this.message = message;
    }
}
