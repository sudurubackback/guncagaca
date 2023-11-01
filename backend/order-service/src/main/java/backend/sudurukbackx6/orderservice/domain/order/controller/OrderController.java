package backend.sudurukbackx6.orderservice.domain.order.controller;

import backend.sudurukbackx6.orderservice.domain.order.dto.OrderRequestDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderResponseDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.StoreOrderResponse;
import backend.sudurukbackx6.orderservice.domain.order.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/order")
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;

    @PostMapping("/add")
    public ResponseEntity<OrderResponseDto> addOrder(@RequestHeader("Email") String email, @RequestBody OrderRequestDto orderRequestDto) {
        return ResponseEntity.ok(orderService.addOrder(orderRequestDto));
    }

    @GetMapping("/store/{storeId}")
    public List<StoreOrderResponse> getStoredOrder (@PathVariable Long storeId){
        return orderService.getStoredOrder(storeId);
    }
}
