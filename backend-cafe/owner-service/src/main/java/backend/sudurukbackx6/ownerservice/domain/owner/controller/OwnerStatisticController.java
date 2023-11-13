package backend.sudurukbackx6.ownerservice.domain.owner.controller;


import backend.sudurukbackx6.ownerservice.domain.owner.dto.GetTodaySellingResponse;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.SalesSummaryResponse;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.StoreOrderResponse;
import backend.sudurukbackx6.ownerservice.domain.owner.service.OwnerStatisticsService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/ceo")
public class OwnerStatisticController {

//    private final OwnerStatisticsService ownerStatisticsService;

//    @GetMapping("/store/{storeId}/orders")
//    public List<StoreOrderResponse> getStoreOrdersForDateRange(
//            @PathVariable Long storeId,
//            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
//            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
//
//        if (startDate == null && endDate == null) {
//            // 두 날짜가 모두 누락된 경우 현재 날짜 등을 사용하거나 기본 범위를 설정할 수 있습니다.
//            // 예: 오늘의 주문만 가져오기
//            startDate = LocalDate.now();
//            endDate = LocalDate.now();
//        } else if (startDate == null || endDate == null) {
//            // 하나의 날짜만 누락된 경우 에러를 반환하거나, 기본값을 설정할 수 있습니다.
//            throw new IllegalArgumentException("Both startDate and endDate are required if one is provided.");
//        }
//
//        // 날짜 범위에 해당하는 주문을 가져오는 서비스 메소드 호출
//        return ownerStatisticsService.getStoreOrdersForDateRange(storeId, startDate, endDate);
//    }
//
//    @GetMapping("/store/{storeId}/orders/summary")
//    public ResponseEntity<backend.sudurukbackx6.ownerservice.domain.owner.dto.SalesSummaryResponse> getSalesSummary(
//            @PathVariable Long storeId,
//            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
//            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
//
//        if (startDate == null || endDate == null) {
//            return ResponseEntity.badRequest().body(null);
//        }
//
//        backend.sudurukbackx6.ownerservice.domain.owner.dto.SalesSummaryResponse summary = ownerStatisticsService.getSalesSummary(storeId, startDate, endDate);
//        return ResponseEntity.ok(summary);
//    }
}
