package backend.sudurukbackx6.gatewayservice.config;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.security.SecurityScheme;
import io.swagger.v3.oas.models.servers.Server;
import org.springdoc.core.GroupedOpenApi;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Configuration
public class SwaggerConfig {
    @Bean
    public List<GroupedOpenApi> apis() {
        List<GroupedOpenApi> apis = new ArrayList<>();
        apis.add(createGroupedOpenApi("회원", "/api/member/**"));
        apis.add(createGroupedOpenApi("사장님", "/api/owner/**"));
        apis.add(createGroupedOpenApi("가게", "/api/store/**"));
        apis.add(createGroupedOpenApi("알림", "/api/notification/**"));
        apis.add(createGroupedOpenApi("주문", "/api/order/**"));
        apis.add(createGroupedOpenApi("결제", "/api/pay/**"));

        return apis;
    }
    private GroupedOpenApi createGroupedOpenApi(String groupName, String pathsToMatch) {
        return GroupedOpenApi.builder()
                .group(groupName)
                .pathsToMatch(pathsToMatch)
                .build();
    }


    @Bean
    public OpenAPI customOpenAPI() {
        return new OpenAPI()
                .addServersItem(new Server().url("http://k9d102.p.ssaty.io:8000"))
//                .components(new Components().addSecuritySchemes("Bearer",
//                        new SecurityScheme().type(SecurityScheme.Type.HTTP).scheme("bearer").bearerFormat("JWT")))
//                .addSecurityItem(new SecurityRequirement().addList("Bearer"))
                .info(new Info().title("근카가카")
                        .description("<근카가카> 프로젝트 API")
                        .version("v3.0.0"));
    }

}
