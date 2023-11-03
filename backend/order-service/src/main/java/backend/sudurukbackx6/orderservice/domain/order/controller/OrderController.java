package backend.sudurukbackx6.orderservice.domain.order.controller;

import backend.sudurukbackx6.orderservice.domain.order.dto.OrderCancelRequestDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderRequestDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderResponseDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.StoreOrderResponse;
import backend.sudurukbackx6.orderservice.domain.order.entity.Order;
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

    // 주문 등록
    @PostMapping("/add")
    public ResponseEntity<OrderResponseDto> addOrder(@RequestHeader("Email") String email, @RequestBody OrderRequestDto orderRequestDto) {
        return ResponseEntity.ok(orderService.addOrder(email, orderRequestDto));
    }

    // 주문 취소
    @PostMapping("/cancel")
    public ResponseEntity<String> cancelOrder(@RequestHeader("Email") String email, @RequestBody OrderCancelRequestDto cancelRequestDto) {
        orderService.cancelOrder(email, cancelRequestDto);

        return ResponseEntity.ok(String.format("{} 주문 취소", cancelRequestDto.getReceiptId()));
    }

    @GetMapping("/store/{storeId}")
    public List<StoreOrderResponse> getStoredOrder (@PathVariable Long storeId){
        return orderService.getStoredOrder(storeId);
    }

    // 사장님이 주문 접수
    @PostMapping("/request/{orderId}")
    public ResponseEntity<String> requestOrder(@RequestHeader("Email") String email, @PathVariable String orderId) {
        return ResponseEntity.ok(orderService.requestOrder(email, orderId));
    }

    // 사장님이 주문 완료
    @PostMapping("/complete/{orderId}")
    public ResponseEntity<String> completeOrder(@RequestHeader("Email") String email, @PathVariable String orderId) {
        return ResponseEntity.ok(orderService.completeOrder(email, orderId));
    }

    // 사용자 주문 목록 조회
    @GetMapping("/member")
    public ResponseEntity<List<Order>> getMemberOrder(@RequestHeader("Email") String email) {
        return ResponseEntity.ok(orderService.getMemberOrder(email));
    }

    // 사용자 주문 목록 조회
    @GetMapping("/{orderId}")
    public ResponseEntity<Order> getOrder(@RequestHeader("Email") String email, @PathVariable String orderId) {
        return ResponseEntity.ok(orderService.getOrder(orderId));
    }
}
