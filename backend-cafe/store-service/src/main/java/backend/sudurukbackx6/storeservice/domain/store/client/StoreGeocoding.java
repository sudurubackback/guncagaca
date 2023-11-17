package backend.sudurukbackx6.storeservice.domain.store.client;

import backend.sudurukbackx6.storeservice.domain.store.client.dto.GeocodingDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient(url = "https://naveropenapi.apigw.ntruss.com", name = "geocoding")
public interface StoreGeocoding {

    // 주소를 좌표로 변환
    @GetMapping(value = "/map-geocode/v2/geocode")
    GeocodingDto.Response transferAddress (
            @RequestHeader("X-NCP-APIGW-API-KEY-ID") String id,
            @RequestHeader("X-NCP-APIGW-API-KEY") String key,
            @RequestParam("query") String query);

}
