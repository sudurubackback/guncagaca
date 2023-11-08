package backend.sudurukbackx6.memberservice.domain.member.client;

import backend.sudurukbackx6.memberservice.domain.member.client.response.StoreResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;

@FeignClient(url = "http://k9d102.p.ssafy.io:8085", name = "store-service")
public interface StoreFeignClient {
    @GetMapping("/api/store/{cafe_id}")
    StoreResponse cafeDetail(@RequestHeader("Authorization") String token, @PathVariable Long cafe_id);
}
