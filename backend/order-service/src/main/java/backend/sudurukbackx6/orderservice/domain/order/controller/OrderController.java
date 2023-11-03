package backend.sudurukbackx6.orderservice.domain.order.controller;

import backend.sudurukbackx6.orderservice.domain.order.dto.*;
import backend.sudurukbackx6.orderservice.domain.order.entity.Order;
import backend.sudurukbackx6.orderservice.domain.order.service.OrderService;
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
    public ResponseEntity<OrderResponseDto> addOrder(@RequestHeader("Email") String email, @RequestBody OrderRequestDto orderRequestDto) {
        return ResponseEntity.ok(orderService.addOrder(email, orderRequestDto));
    }

    // 주문 취소
    @PostMapping("/cancel")
    public ResponseEntity<String> cancelOrder(@RequestHeader("Email") String email, @RequestBody OrderCancelRequestDto cancelRequestDto) {
        orderService.cancelOrder(email, cancelRequestDto);

        return ResponseEntity.ok(String.format("{} 주문 취소", cancelRequestDto.getReceiptId()));
    }

    @GetMapping("/store/{storeId}/orders")
    public List<StoreOrderResponse> getStoreOrdersForDateRange(
            @PathVariable Long storeId,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {

        if (startDate == null && endDate == null) {
            // 두 날짜가 모두 누락된 경우 현재 날짜 등을 사용하거나 기본 범위를 설정할 수 있습니다.
            // 예: 오늘의 주문만 가져오기
            startDate = LocalDate.now();
            endDate = LocalDate.now();
        } else if (startDate == null || endDate == null) {
            // 하나의 날짜만 누락된 경우 에러를 반환하거나, 기본값을 설정할 수 있습니다.
            throw new IllegalArgumentException("Both startDate and endDate are required if one is provided.");
        }

        // 날짜 범위에 해당하는 주문을 가져오는 서비스 메소드 호출
        return orderService.getStoreOrdersForDateRange(storeId, startDate, endDate);
    }

    @GetMapping("/store/{storeId}/orders/summary")
    public ResponseEntity<SalesSummaryResponse> getSalesSummary(
            @PathVariable Long storeId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {

        if (startDate == null || endDate == null) {
            return ResponseEntity.badRequest().body(null);
        }

        SalesSummaryResponse summary = orderService.getSalesSummary(storeId, startDate, endDate);
        return ResponseEntity.ok(summary);
    }

    @GetMapping("waitlist/{storeId}")
    public ResponseEntity<BaseResponseBody> getWaitList(@PathVariable Long storeId) {
        return ResponseEntity.status(HttpStatus.CREATED).body(new BaseResponseBody<>(200, "사업자 인증 성공"));
    }

    @GetMapping("/list/{storeId}/{status}")
    public BaseResponseBody<List<OrderResponseDto>> getOrderList(@PathVariable Long storeId, @PathVariable String status) {
//        return ResponseEntity.ok(orderService.getOrdersByStoreId(storeId));
        //status가 1일 경우 order 조회
        if (status.equals("1")) {
            return new BaseResponseBody<>(200, "주문 조회 성공", orderService.getOrdersByStoreId(storeId));
        }

        //status가 2일 경우 preparing조회
        else if (status.equals("2")) {
            return new BaseResponseBody<>(200, "preparing 조회 성공", orderService.getPreparingByStoreId(storeId));
        }
        //status가 3인 경우 done조회
        else if (status.equals("3")) {
            return new BaseResponseBody<>(200, "done 조회 성공", orderService.getDoneByStoreId(storeId));
        }

        //status가 4인경우 cancle
        else if (status.equals("4")) {
            return new BaseResponseBody<>(200, "cancle 조회 성공", orderService.getCancleByStoreId(storeId));
        }

        else {
            return new BaseResponseBody<>(400, "조회 실패", null);
        }

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
