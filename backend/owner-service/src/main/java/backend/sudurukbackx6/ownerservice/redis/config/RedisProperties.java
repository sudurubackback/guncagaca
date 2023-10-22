package backend.sudurukbackx6.ownerservice.redis.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;
@Component
@ConfigurationProperties(prefix = "spring.redis")
@Setter
@Getter
public class RedisProperties {
    private int port;
    private String host;
}