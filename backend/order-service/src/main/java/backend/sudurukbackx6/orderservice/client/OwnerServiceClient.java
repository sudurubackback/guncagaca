package backend.sudurukbackx6.orderservice.client;

import backend.sudurukbackx6.orderservice.domain.order.dto.OrderRequestDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderResponseDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@FeignClient(url = "http://localhost:8086", name="owner-service")
public interface OwnerServiceClient {

//    @PostMapping("/api/ceo/menu/order")
//    OrderIndexResponseDto getOrder(@RequestBody OrderRequestDto orderRequestDto);

}
