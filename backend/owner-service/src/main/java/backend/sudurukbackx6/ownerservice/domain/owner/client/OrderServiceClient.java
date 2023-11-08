package backend.sudurukbackx6.ownerservice.domain.owner.client;


import backend.sudurukbackx6.ownerservice.domain.owner.client.dto.SalesSummaryResponse;
import backend.sudurukbackx6.ownerservice.domain.owner.client.dto.StoreOrderResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.util.List;

@FeignClient(url = "k9d102.p.ssafy.io:8083", name = "order-service")
public interface OrderServiceClient {

    @GetMapping("/api/order/store/{storeId}")
    List<StoreOrderResponse> getStoredOrder(@PathVariable("storeId") Long storeId);


    @GetMapping("/api/order/store/{storeId}/orders")
    List<StoreOrderResponse> getStoreOrdersForDateRange(
            @PathVariable("storeId") Long storeId,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate);

    @GetMapping("/store/{storeId}/orders/summary")
    SalesSummaryResponse getSalesSummary(
            @PathVariable("storeId") Long storeId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate);
}