package backend.sudurukbackx6.ownerservice.openAPI.service;

import backend.sudurukbackx6.ownerservice.openAPI.config.VendorProperties;
import backend.sudurukbackx6.ownerservice.domain.business.dto.request.VendorValidateReqDto;
import backend.sudurukbackx6.ownerservice.openAPI.dto.response.VenderResDto;
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
    public int checkVendorValidation(VendorValidateReqDto reqDto) throws URISyntaxException {

//        VendorReqDto request = new VendorReqDto(reqDto.getBusiness_number(), reqDto.getOpen_date(), reqDto.getOwner_name());
//        ArrayList<VendorReqDto> list = new ArrayList<>();   //list형식으로 전달해야하기 때문이다.
//        list.add(request);

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
