package backend.sudurukbackx6.notificationservice.common.error.exception;

import backend.sudurukbackx6.notificationservice.common.error.code.ErrorCode;
import lombok.Getter;

@Getter
public class BadRequestException extends RuntimeException {

    private ErrorCode errorCode;

    public BadRequestException(ErrorCode errorCode) {
        super(errorCode.getMessage());
        this.errorCode = errorCode;
    }
}
