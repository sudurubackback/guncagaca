package com.sudurukbackx6.adminservice.domain.admin.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "admin")
@Setter
@Getter
@RefreshScope
public class AdminProperties {
    private String email;
    private String password;
}
