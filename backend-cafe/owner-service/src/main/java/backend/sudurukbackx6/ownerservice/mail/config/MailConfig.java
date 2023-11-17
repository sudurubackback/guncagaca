package backend.sudurukbackx6.ownerservice.mail.config;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;

import java.util.Properties;

@RequiredArgsConstructor
@Configuration
public class MailConfig {

    private final MailProperties mailProperties;

    private Properties getMailProperties() {
        Properties properties = new Properties();

        properties.put("mail.smtp.auth", mailProperties.getProperties().getSmtp().isAuth());
        properties.put("mail.smtp.starttls.enable", mailProperties.getProperties().getSmtp().getStarttls().isEnable());
        properties.put("mail.smtp.starttls.required", mailProperties.getProperties().getSmtp().getStarttls().isRequired());

        return properties;
    }
}
