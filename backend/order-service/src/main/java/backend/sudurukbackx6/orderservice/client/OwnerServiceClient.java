package backend.sudurukbackx6.orderservice.client;

import backend.sudurukbackx6.orderservice.domain.order.dto.OrderRequestDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderResponseDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;

@FeignClient(url = "k9d102.p.ssafy.io:8086/", name="owner-service")
public interface OwnerServiceClient {

    @GetMapping("/api/ceo/menu/order")
    OrderResponseDto getOrder(@RequestBody OrderRequestDto orderRequestDto);
}
