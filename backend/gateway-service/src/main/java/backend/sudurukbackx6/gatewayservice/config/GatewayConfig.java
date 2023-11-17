package backend.sudurukbackx6.gatewayservice.config;

import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;

@Configuration
public class GatewayConfig {

    @Bean
    public RouteLocator routeLocator(RouteLocatorBuilder builder) {
        return builder.routes()
                .route(r -> r.path("/store-service/v3/api-docs")
                        .and()
                        .method(HttpMethod.GET)
                        .uri("lb://STORE-SERVICE"))
                .route(r -> r.path("/member-service/v3/api-docs")
                        .and()
                        .method(HttpMethod.GET)
                        .uri("lb://MEMBER-SERVICE"))
                .route(r -> r.path("/owner-service/v3/api-docs")
                        .and()
                        .method(HttpMethod.GET)
                        .uri("lb://OWNER-SERVICE"))
                .route(r -> r.path("/order-service/v3/api-docs")
                        .and()
                        .method(HttpMethod.GET)
                        .uri("lb://ORDER-SERVICE"))
                .route(r -> r.path("/notification-service/v3/api-docs")
                        .and()
                        .method(HttpMethod.GET)
                        .uri("lb://NOTIFICATION-SERVICE"))
                .route(r -> r.path("/pay-service/v3/api-docs")
                        .and()
                        .method(HttpMethod.GET)
                        .uri("lb://PAY-SERVICE"))
                .route(r -> r.path("/admin-service/v3/api-docs")
                        .and()
                        .method(HttpMethod.GET)
                        .uri("lb://ADMIN-SERVICE"))
                .build();
    }
}
