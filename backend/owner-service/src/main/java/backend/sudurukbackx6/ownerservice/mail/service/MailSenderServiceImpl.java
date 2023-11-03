package backend.sudurukbackx6.ownerservice.mail.service;

import backend.sudurukbackx6.ownerservice.common.error.code.ErrorCode;
import backend.sudurukbackx6.ownerservice.common.error.exception.BadRequestException;
import backend.sudurukbackx6.ownerservice.redis.util.RedisUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.security.SecureRandom;

@Slf4j
@Service
@RequiredArgsConstructor
public class MailSenderServiceImpl implements MailSenderService {

    private final JavaMailSender mailSender;
    private final RedisUtil redisUtil;
    private static final String ALPHABET = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    private static final int CODE_LENGTH = 10;
    private static final SecureRandom RANDOM = new SecureRandom();


    //숫자와 영어의 대소문자를 섞어서 10자리 랜덤 인증코드를 만드는 함수
    @Override
    public String makeRandomCode() {
        StringBuilder sb = new StringBuilder(CODE_LENGTH);
        for (int i = 0; i < CODE_LENGTH; i++) {
            sb.append(ALPHABET.charAt(RANDOM.nextInt(ALPHABET.length())));
        }
        return sb.toString();
    }

    @Override
    public String sendCode(String email) {
        SimpleMailMessage message = new SimpleMailMessage();
        String code = makeRandomCode();
        message.setTo(email);
        message.setSubject("근카 가카 인증코드 입니다.");
        message.setText("인증코드 : " + code);

        //인증코드를 redis에 저장
        redisUtil.saveCode(email, code);

        try {
            mailSender.send(message);
            return code;
        } catch (RuntimeException e) {
            log.debug("MailService.sendEmail exception occur email: {}, ",
                    email);
            throw new BadRequestException(ErrorCode.FAIL_SENDMAIL);
        }
    }

    @Override
    public boolean checkCode(String email, String code) {
        //email을 key로 가지는 redis에 저장된 코드를 입력
        String redisCode = redisUtil.getCode(email);
        if (redisCode == null)
            throw new BadRequestException(ErrorCode.DONT_MATCH_CODE);
        return redisCode.equals(code);
    }

    @Override
    public String sendPassword(String email) throws MessagingException {
        SimpleMailMessage message = new SimpleMailMessage();
        String code = makeRandomCode();
        message.setTo(email);
        message.setSubject("근카 가카 임시 비밀번호 입니다.");
        message.setText("임시 비밀번호 : " + code);

        //인증코드를 redis에 저장
        redisUtil.saveCode(email, code);

        try {
            mailSender.send(message);
            return code;
        } catch (RuntimeException e) {
            log.debug("MailService.sendEmail exception occur email: {}, ",
                    email);
            throw new BadRequestException(ErrorCode.FAIL_SENDMAIL);
        }
    }

    @Override
    public void sendInfoMail(String email) throws MessagingException {

//        SimpleMailMessage message = new SimpleMailMessage();
//        message.setTo(email);
//        message.setSubject("근카 가카 가입 서류 안내");
//
//        String sb = "<h1>" + "근카 가카 가입 서류 안내" + "<h1><br>" +
//                "사업자 인증 서류, 신분증 사본을 본 이메일로 회신 바랍니다.<br><br>";
//
//        message.setText(sb);
//
//
//        try {
//            mailSender.send(message);
//
//        } catch (RuntimeException e) {
//            log.debug("MailService.sendEmail exception occur email: {}, ",
//                    email);
//            throw new BadRequestException(ErrorCode.FAIL_SENDMAIL);
//        }

        MimeMessage message = mailSender.createMimeMessage();

        // true parameter indicates that we want to use multipart (it's necessary for html emails)
        MimeMessageHelper helper = new MimeMessageHelper(message, true);

        helper.setTo(email);
        helper.setSubject("근카 가카 가입 서류 안내");

        String htmlContent = "<h1>근카 가카 가입 서류 안내</h1><br>" +  // Here, closing tag for h1 was corrected from <h1> to </h1>
                "사업자 인증 서류, 신분증 사본을 본 이메일로 회신 바랍니다.<br><br>";

        helper.setText(htmlContent, true); // true to activate HTML format

        try {
            mailSender.send(message);
        } catch (RuntimeException e) {
            log.debug("MailService.sendEmail exception occur email: {}, ", email);
            throw new BadRequestException(ErrorCode.FAIL_SENDMAIL);
        }
    }

}
