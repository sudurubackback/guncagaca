package backend.sudurukbackx6.ownerservice.openAPI.service;

import backend.sudurukbackx6.ownerservice.openAPI.config.VendorProperties;
import backend.sudurukbackx6.ownerservice.domain.business.dto.request.VendorVailidateReqDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.HttpHeaders;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@Service
public class VendorServiceImpl implements VendorService{
    private final VendorProperties vendorProperties;
    
    //사업자가 유효한지 확인만 해주면 된다.
    @Override
    public boolean checkVendorValidation(VendorVailidateReqDto reqDto) {


        String requestBody = "{\n" +
                "  \"businesses\": [\n" +
                "    {\n" +
                "      \"b_no\": \"" + reqDto.getBusiness_number() + "\",\n" +
                "      \"start_dt\": \"" + reqDto.getOpen_date()+ "\",\n" +
                "      \"p_nm\": \"" + reqDto.getOwner_name() + "\",\n" +
                "    }\n" +
                "  ]\n" +
                "}";

        WebClient webClient = WebClient.builder()
                .baseUrl(vendorProperties.getVaildURL() + vendorProperties.getServiceKey())
                .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .build();

        Mono<Map<String, String>> responseMono = webClient.post()
                .bodyValue(requestBody)
                .retrieve()
                .bodyToMono(new ParameterizedTypeReference<Map<String, String>>() {});

        Map<String, String> response = responseMono.block();

        return response != null && "OK".equals(response.get("status_code"));
    }
}
