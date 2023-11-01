package backend.sudurukbackx6.ownerservice.domain.owner.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

@FeignClient(name = "order-service")
public interface OrderServiceClient {

    @GetMapping
}
