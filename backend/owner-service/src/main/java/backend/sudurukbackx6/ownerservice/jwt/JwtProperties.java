package backend.sudurukbackx6.ownerservice.jwt;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "jwt")
@Setter
@Getter
public class JwtProperties {
    String header;
    String secret;
    String issuer;
}
