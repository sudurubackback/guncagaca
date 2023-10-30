package backend.sudurukbackx6.orderservice.client;

import backend.sudurukbackx6.orderservice.domain.order.dto.OrderRequestDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderIndexResponseDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;

@FeignClient("owner-service")
public interface OwnerServiceClient {

    @GetMapping("/menu/order")
    OrderIndexResponseDto getOrder(@RequestBody OrderRequestDto orderRequestDto);
}
