package backend.sudurukbackx6.gatewayservice.util;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "jwt")
@Setter
@Getter
@RefreshScope
public class JwtProperties {
    String header;
    String secret;
    String issuer;
}
