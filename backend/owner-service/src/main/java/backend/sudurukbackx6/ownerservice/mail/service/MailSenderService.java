package backend.sudurukbackx6.ownerservice.mail.service;

import javax.mail.MessagingException;

public interface MailSenderService {
    //랜덤 난수 생성
    String makeRandomCode();
    String sendCode(String email) throws MessagingException;
    //코드일치 체크
    boolean checkCode(String email, String code);
    String sendPassword(String password) throws MessagingException;
}
