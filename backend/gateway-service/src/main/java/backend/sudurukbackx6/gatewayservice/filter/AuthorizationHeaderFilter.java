package backend.sudurukbackx6.gatewayservice.filter;

import backend.sudurukbackx6.gatewayservice.util.JwtUtil;
import backend.sudurukbackx6.gatewayservice.util.RedisUtil;
import io.jsonwebtoken.Claims;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

@Component
@Slf4j
public class AuthorizationHeaderFilter extends AbstractGatewayFilterFactory<AuthorizationHeaderFilter.Config> {

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private RedisUtil redisUtil;

    Environment env;

    public AuthorizationHeaderFilter(Environment env) {
        super(Config.class);
        this.env = env;
    }

    public static class Config {

    }

    // login -> token -> user (with token) -> header (include token)
    @Override
    public GatewayFilter apply(Config config) {
        return (exchange, chain) -> {
            ServerHttpRequest request = exchange.getRequest();

            // Authorization Header가 없는 경우
            if (!request.getHeaders().containsKey(HttpHeaders.AUTHORIZATION)) {
                return onError(exchange, "no authorization header", HttpStatus.UNAUTHORIZED);
            }

            String authorizationHeader = request.getHeaders().get(HttpHeaders.AUTHORIZATION).get(0);
            String token = authorizationHeader.replace("Bearer ", "");

            // Token값이 잘못된 경우
            if (!isJwtValid(token)) {
                return onError(exchange, "no authorization header", HttpStatus.UNAUTHORIZED);
            }

            // 유효기간이 지난 Token인 경우
            if (!isJwtValidExpiration(token)) {
                return onError(exchange, "over expiration token", HttpStatus.UNAUTHORIZED);
            }

            ServerHttpRequest newRequest = request.mutate()
                    .header("Email", jwtUtil.extractEmail(token))
                    .build();

            return chain.filter(exchange.mutate().request(newRequest).build());
        };
    }

    private boolean isJwtValid(String token) {
        try {
            jwtUtil.get(token);
        } catch (Exception ex) {
            return false;
        }
        // 복호화 후 검증
        return true;
    }

    private boolean isJwtValidExpiration(String token) {
        return !jwtUtil.isExpiration(token);
    }

    private Mono<Void> onError(ServerWebExchange exchange, String err, HttpStatus httpStatus) {
        ServerHttpResponse response = exchange.getResponse();
        response.setStatusCode(httpStatus);

        log.error(err);
        return response.setComplete();
    }
}
