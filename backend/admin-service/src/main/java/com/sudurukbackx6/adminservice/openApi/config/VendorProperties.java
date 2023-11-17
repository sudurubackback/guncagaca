package com.sudurukbackx6.adminservice.openApi.config;

import lombok.*;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Component;

@Component
@Getter
@Setter
@RefreshScope
@ConfigurationProperties(prefix = "vendor")
public class VendorProperties {
    private String vaildURL;
    private String serviceKey;
}