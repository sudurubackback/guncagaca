package backend.sudurukbackx6.orderservice.domain.order.service;

import backend.sudurukbackx6.orderservice.client.OwnerServiceClient;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderRequestDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderIndexResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class OrderService {
    private final OwnerServiceClient ownerServiceClient;

    public OrderIndexResponseDto addOrder(OrderRequestDto orderRequestDto) {

        OrderIndexResponseDto order = ownerServiceClient.getOrder(orderRequestDto);

        return new OrderIndexResponseDto();
    }

}
