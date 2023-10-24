package backend.sudurukbackx6.ownerservice.mail.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;


@Component
@ConfigurationProperties(prefix = "spring.mail")
@Setter
@Getter
public class MailProperties {
    private String host;
    private int port;
    private String username;
    private String password;
    private Properties properties = new Properties();

    @Setter
    @Getter
    public static class Properties {
        private Smtp smtp = new Smtp();

        @Setter
        @Getter
        public static class Smtp {
            private boolean auth;
            private Starttls starttls = new Starttls();

            @Setter
            @Getter
            public static class Starttls {
                private boolean enable;
                private boolean required;
            }
        }
    }
}

