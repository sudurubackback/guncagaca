package backend.sudurukbackx6.ownerservice.common.error.code;

import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public enum ErrorCode {

    //OWNER_LOGIN
    NOT_EXISTS_OWNER(HttpStatus.BAD_REQUEST, 4001, "가입 되지 않은 회원입니다."),
    USER_NOT_MATCH(HttpStatus.BAD_REQUEST, 4002, "아이디 혹은 비밀번호를 확인하세요."),
    USER_EXISTS(HttpStatus.BAD_REQUEST, 4000, "이미 가입된 회원입니다."),

    //OWNER_TOKEN
    NOT_VALID_ACCESS_TOKEN(HttpStatus.UNAUTHORIZED, 4001, "ACCESSTOKEN이 유효하지 않습니다."),
    NOT_VALID_REFRESH_TOKEN(HttpStatus.UNAUTHORIZED, 4001, "REFRESHTOEN이 유효하지 않습니다."),



    FAIL_SENDMAIL(HttpStatus.BAD_REQUEST, 4001, "이메일 전송에 실패하였습니다."),
    DONT_MATCH_CODE(HttpStatus.BAD_REQUEST, 4002, "인증코드가 일치하지 않습니다.");


    private HttpStatus httpStatus;
    private int errorCode;
    private String message;

    ErrorCode(HttpStatus httpStatus, int errorCode, String message) {
        this.httpStatus = httpStatus;
        this.errorCode = errorCode;
        this.message = message;
    }

}
