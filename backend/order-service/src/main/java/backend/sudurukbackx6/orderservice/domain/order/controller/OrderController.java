package backend.sudurukbackx6.orderservice.domain.order.controller;


import backend.sudurukbackx6.orderservice.domain.order.dto.*;
import backend.sudurukbackx6.orderservice.domain.order.dto.response.OrderListResDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderCancelRequestDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderRequestDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderResponseDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.StoreOrderResponse;
import backend.sudurukbackx6.orderservice.domain.order.entity.Order;
import backend.sudurukbackx6.orderservice.domain.order.service.OrderService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
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

    @GetMapping("waitlist/{storeId}")
    public ResponseEntity<BaseResponseBody> getWaitList(@PathVariable Long storeId) {
        return ResponseEntity.status(HttpStatus.CREATED).body(new BaseResponseBody<>(200, "사업자 인증 성공"));
    }

    // 사용자 주문 목록 조회
    @GetMapping("/member")
    @Operation(summary = "회원 주문 내역 조회", description = "현재 회원의 주문 내역 조회", tags = { "Order Controller" })
    public ResponseEntity<List<Order>> getMemberOrder(@RequestHeader("Email") String email ) {
        return ResponseEntity.ok(orderService.getMemberOrder(email));
    }

    // 특정 가게 사용자 주문 목록 조회
    @GetMapping("/member/{storeId}")
    @Operation(summary = "특정 가게 회원 주문 내역 조회", description = "현재 회원의 특정 가게 주문 내역 조회", tags = { "Order Controller" })
    public ResponseEntity<List<Order>> getMemberStoreOrder(@RequestHeader("Email") String email, @PathVariable Long storeId) {
        return ResponseEntity.ok(orderService.getMemberStoreOrder(email,storeId));
    }

    // 사용자 주문 목록 조회
    @GetMapping("/{orderId}")
    @Operation(summary = "특정 주문 조회", description = "단일 주문 조회", tags = { "Order Controller" })
    public ResponseEntity<Order> getOrder(@RequestHeader("Email") String email, @PathVariable String orderId) {
        return ResponseEntity.ok(orderService.getOrder(orderId));
    }
}
