package backend.sudurukbackx6.ownerservice.domain.owner.client;


import backend.sudurukbackx6.ownerservice.domain.owner.client.dto.StoreOrderResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@FeignClient(url = "k9d102.p.ssafy.io:8083", name = "order-service")
public interface OrderServiceClient {

    @GetMapping("/api/order/store/{storeId}")
    List<StoreOrderResponse> getStoredOrder (@PathVariable("storeId") Long storeId);

}
