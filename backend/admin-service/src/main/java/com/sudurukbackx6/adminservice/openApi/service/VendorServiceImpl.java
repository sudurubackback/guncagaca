package com.sudurukbackx6.adminservice.openApi.service;

import com.sudurukbackx6.adminservice.domain.owner.dto.request.BusinessValidReqDto;
import com.sudurukbackx6.adminservice.openApi.config.VendorProperties;
import com.sudurukbackx6.adminservice.openApi.dto.response.VenderResDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.util.DefaultUriBuilderFactory;
import reactor.core.publisher.Mono;

import java.net.URISyntaxException;

@Slf4j
@RequiredArgsConstructor
@Service
public class VendorServiceImpl implements VendorService {
    private final VendorProperties vendorProperties;

    //사업자가 유효한지 확인만 해주면 된다.
    @Override
    public int checkVendorValidation(BusinessValidReqDto reqDto) throws URISyntaxException {

        String requestBody = "{\n" +
                "  \"businesses\": [\n" +
                "    {\n" +
                "      \"b_no\": \"" + reqDto.getBusiness_number() + "\",\n" +
                "      \"start_dt\": \"" + reqDto.getOpen_date() + "\",\n" +
                "      \"p_nm\": \"" + reqDto.getOwner_name() + "\",\n" +
                "      \"p_nm2\": \"" + "" + "\",\n" +
                "      \"b_nm\": \"" + "" + "\",\n" +
                "      \"corp_no\": \"" + "" + "\",\n" +
                "      \"b_sector\": \"" + "" + "\",\n" +
                "      \"b_type\": \"" + "" + "\"\n" +
                "    }\n" +
                "  ]\n" +
                "}";

        DefaultUriBuilderFactory factory = new DefaultUriBuilderFactory(vendorProperties.getVaildURL());
        factory.setEncodingMode(DefaultUriBuilderFactory.EncodingMode.VALUES_ONLY);

        WebClient webClient = WebClient.builder()
                .uriBuilderFactory(factory)
                .baseUrl(vendorProperties.getVaildURL())
                .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)

                .build();

        Mono<VenderResDto> responseMono = webClient.post()
                .uri(uriBuilder -> uriBuilder
                        .queryParam("serviceKey", vendorProperties.getServiceKey())
                        .build())
                .bodyValue(requestBody)
                .retrieve()
                .bodyToMono(VenderResDto.class);

        return responseMono.block().getValid_cnt();
    }
}
