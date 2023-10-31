package backend.sudurukbackx6.memberservice.domain.points.client;

import backend.sudurukbackx6.memberservice.domain.points.client.response.StoreResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "store-service") // "store-service"는 Store 서비스의 이름입니다. 필요에 따라 수정하세요.
public interface StoreFeignClient {
    @GetMapping("/store/cafe/{cafe_id}")
    StoreResponse cafeDetail(@PathVariable Long cafe_id);
}
