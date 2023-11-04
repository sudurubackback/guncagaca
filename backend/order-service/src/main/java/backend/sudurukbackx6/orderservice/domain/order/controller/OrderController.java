package backend.sudurukbackx6.orderservice.domain.order.controller;

import backend.sudurukbackx6.orderservice.domain.order.dto.OrderCancelRequestDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderRequestDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderResponseDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.StoreOrderResponse;
import backend.sudurukbackx6.orderservice.domain.order.entity.Order;
import backend.sudurukbackx6.orderservice.domain.order.service.OrderService;
import io.swagger.v3.oas.annotations.Operation;
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
    @Operation(summary = "주문등록", description = "결제 후 주문 내역 생성", tags = { "Order Controller" })
    public ResponseEntity<OrderResponseDto> addOrder(@RequestHeader("Email") String email, @RequestBody OrderRequestDto orderRequestDto) {
        return ResponseEntity.ok(orderService.addOrder(email, orderRequestDto));
    }

    // 주문 취소
    @PostMapping("/cancel")
    @Operation(summary = "주문취소", description = "결제 시 생성된 receiptId로 결제 취소 후 주문 취소 처리", tags = { "Order Controller" })
    public ResponseEntity<String> cancelOrder(@RequestHeader("Email") String email, @RequestBody OrderCancelRequestDto cancelRequestDto) {

        if (orderService.cancelOrder(email, cancelRequestDto)) {
            return ResponseEntity.ok(String.format("%s 주문 취소", cancelRequestDto.getReceiptId()));
        }
        return ResponseEntity.ok("실패");
    }

    @GetMapping("/store/{storeId}")
    @Operation(summary = "사장님 주문 조회", description = "주문 조회", tags = { "Owner Controller" })
    public List<StoreOrderResponse> getStoredOrder (@PathVariable Long storeId){
        return orderService.getStoredOrder(storeId);
    }

    // 사장님이 주문 접수
    @PostMapping("/request/{orderId}")
    @Operation(summary = "주문 접수 처리", description = "사장님이 주문 확인 후 접수 처리", tags = { "Owner Controller" })
    public ResponseEntity<String> requestOrder(@RequestHeader("Email") String email, @PathVariable String orderId) {
        return ResponseEntity.ok(orderService.requestOrder(email, orderId));
    }

    // 사장님이 주문 완료
    @PostMapping("/complete/{orderId}")
    @Operation(summary = "주문 완료 처리", description = "사장님이 주문 준비 완료 처리", tags = { "Owner Controller" })
    public ResponseEntity<String> completeOrder(@RequestHeader("Email") String email, @PathVariable String orderId) {
        return ResponseEntity.ok(orderService.completeOrder(email, orderId));
    }

    // 사용자 주문 목록 조회
    @GetMapping("/member")
    @Operation(summary = "회원 주문 내역 조회", description = "현재 회원의 주문 내역 조회", tags = { "Order Controller" })
    public ResponseEntity<List<Order>> getMemberOrder(@RequestHeader("Email") String email) {
        return ResponseEntity.ok(orderService.getMemberOrder(email));
    }

    // 사용자 주문 목록 조회
    @GetMapping("/{orderId}")
    @Operation(summary = "특정 주문 조회", description = "단일 주문 조회", tags = { "Order Controller" })
    public ResponseEntity<Order> getOrder(@RequestHeader("Email") String email, @PathVariable String orderId) {
        return ResponseEntity.ok(orderService.getOrder(orderId));
    }
}
