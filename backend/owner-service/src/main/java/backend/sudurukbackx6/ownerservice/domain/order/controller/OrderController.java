package backend.sudurukbackx6.ownerservice.domain.order.controller;

import backend.sudurukbackx6.ownerservice.domain.order.dto.*;
import backend.sudurukbackx6.ownerservice.domain.order.entity.Order;
import backend.sudurukbackx6.ownerservice.domain.order.service.OrderService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("api/ceo")
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;

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

//    @GetMapping("/store/{storeId}/orders/summary")
//    public ResponseEntity<SalesSummaryResponse> getSalesSummary(
//            @PathVariable Long storeId,
//            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
//            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
//
//        if (startDate == null || endDate == null) {
//            return ResponseEntity.badRequest().body(null);
//        }
//
//        SalesSummaryResponse summary = orderService.getSalesSummary(storeId, startDate, endDate);
//        return ResponseEntity.ok(summary);
//    }

    @GetMapping("/list/{storeId}/{status}")
    public BaseResponseBody<List<OrderListResDto>> getOrderList(@PathVariable Long storeId, @PathVariable String status) {
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
    @GetMapping("/{orderId}")
    @Operation(summary = "특정 주문 조회", description = "단일 주문 조회", tags = { "Order Controller" })
    public ResponseEntity<Order> getOrder(@RequestHeader("Email") String email, @PathVariable String orderId) {
        return ResponseEntity.ok(orderService.getOrder(orderId));
    }
}
