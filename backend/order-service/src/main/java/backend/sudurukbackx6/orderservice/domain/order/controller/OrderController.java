package backend.sudurukbackx6.orderservice.domain.order.controller;

import backend.sudurukbackx6.orderservice.domain.order.dto.OrderCancelRequestDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderRequestDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderResponseDto;
import backend.sudurukbackx6.orderservice.domain.order.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/order")
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;

    // 주문 등록
    @PostMapping("/add")
    public ResponseEntity<OrderResponseDto> addOrder(@RequestHeader("Email") String email, @RequestBody OrderRequestDto orderRequestDto) {
        return ResponseEntity.ok(orderService.addOrder(orderRequestDto));
    }

    // 주문 취소
    @PostMapping("/cancel")
    public ResponseEntity<String> cancelOrder(@RequestHeader("Email") String email, @RequestBody OrderCancelRequestDto cancelRequestDto) {
        orderService.cancelOrder(email, cancelRequestDto);

        return ResponseEntity.ok(String.format("{} 주문 취소", cancelRequestDto.getReceiptId()));
    }

}
