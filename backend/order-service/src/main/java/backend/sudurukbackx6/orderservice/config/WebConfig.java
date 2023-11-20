package backend.sudurukbackx6.orderservice.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOrigins("https://hoilday5303.store") // 허용할 도메인을 명시
                .allowedMethods("GET", "POST", "PUT", "DELETE") // 허용할 HTTP 메소드를 명시
                .allowCredentials(true); // 필요에 따라 쿠키 전송을 허용
    }
}