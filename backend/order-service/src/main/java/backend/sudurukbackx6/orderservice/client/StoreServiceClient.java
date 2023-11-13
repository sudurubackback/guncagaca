package backend.sudurukbackx6.orderservice.client;

import backend.sudurukbackx6.orderservice.domain.order.dto.StoreInfoDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient(url = "http://k9d102.p.ssafy.io:8085", name="store-service")
public interface StoreServiceClient {

    @GetMapping("/api/store/{cafeId}")
    StoreInfoDto getStore(@RequestParam("Email") String email, @PathVariable Long cafeId);
}
