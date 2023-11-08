package backend.sudurukbackx6.notificationservice.common.error.code;

import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public enum ErrorCode {

    DONT_MATCH_CODE(HttpStatus.BAD_REQUEST, 4002, "인증코드가 일치하지 않습니다."),
    EMPTY_FIREBASE_TOKEN(HttpStatus.BAD_REQUEST, 4003, "Firebase 토큰이 비어있습니다.");

    private HttpStatus httpStatus;
    private int errorCode;
    private String message;

    ErrorCode(HttpStatus httpStatus, int errorCode, String message) {
        this.httpStatus = httpStatus;
        this.errorCode = errorCode;
        this.message = message;
    }

}
