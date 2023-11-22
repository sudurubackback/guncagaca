package backend.sudurukbackx6.orderservice.domain.order.controller;


import backend.sudurukbackx6.orderservice.domain.order.dto.*;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderCancelRequestDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderRequestDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderResponseDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.StoreOrderResponse;
import backend.sudurukbackx6.orderservice.domain.order.entity.Order;
import backend.sudurukbackx6.orderservice.domain.order.service.OrderService;
import backend.sudurukbackx6.orderservice.domain.order.service.SseService;
import com.fasterxml.jackson.core.JsonProcessingException;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/order")
@RequiredArgsConstructor
@CrossOrigin
public class OrderController {

    private final OrderService orderService;
    private final SseService sseService;

    // 주문 등록
    @PostMapping("/add")
    @Operation(summary = "주문등록", description = "결제 후 주문 내역 생성", tags = { "Order Controller" })
    public ResponseEntity<OrderResponseDto> addOrder(@RequestHeader("Email") String email, @RequestBody OrderRequestDto orderRequestDto) {
        return ResponseEntity.ok(orderService.addOrder(email, orderRequestDto));
    }

    // 주문 취소
    @PostMapping("/cancel")
    @Operation(summary = "주문취소", description = "결제 시 생성된 receiptId로 결제 취소 후 주문 취소 처리", tags = { "Order Controller" })
    public ResponseEntity<String> cancelOrder(@RequestHeader("Email") String email, @RequestBody OrderCancelRequestDto cancelRequestDto) throws JsonProcessingException {

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

//   @GetMapping("/store/{storeId}/orders/summary")
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

    // 기간 설정해서 주문 조회
    @GetMapping("list/{storeId}")
    public BaseResponseBody<List<Order>> getWaitList(@PathVariable Long storeId,
                                                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime  startDate,
                                                        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate) {
        return new BaseResponseBody<>(200, "주문 조회 성공",  orderService.getOrdersByDateTime(storeId, startDate, endDate));
    }

    // 주문 상태별 주문 조회
    @GetMapping("/list/{storeId}/{status}")
    public BaseResponseBody<List<Order>> getOrderList(@PathVariable Long storeId, @PathVariable String status) {
        //status가 1일 경우 order 조회
        if (status.equals("1")) {
            return new BaseResponseBody<>(200, "ordered 조회 성공", orderService.getOrdersByStoreId(storeId));
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
    public ResponseEntity<String> requestOrder(@RequestHeader("Email") String email, @PathVariable String orderId) throws JsonProcessingException {
        return ResponseEntity.ok(orderService.requestOrder(email, orderId));
    }

    // 사장님이 주문 완료
    @PostMapping("/complete/{orderId}")
    @Operation(summary = "주문 완료 처리", description = "사장님이 주문 준비 완료 처리", tags = { "Owner Controller" })
    public ResponseEntity<String> completeOrder(@RequestHeader("Email") String email, @PathVariable String orderId) throws JsonProcessingException {
        return ResponseEntity.ok(orderService.completeOrder(email, orderId));
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

    @GetMapping("/sse/{storeId}")
    public SseEmitter subscribeToSse(@PathVariable Long storeId) {
        return sseService.createEmitter(storeId);
    }
}
