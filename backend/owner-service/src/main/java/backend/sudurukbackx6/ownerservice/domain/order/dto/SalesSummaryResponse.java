package backend.sudurukbackx6.ownerservice.domain.order.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Map;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SalesSummaryResponse {
    private BigDecimal totalSales;
    private Map<String, Integer> menuSalesCount; // 메뉴별 판매 수량
    private Map<Integer, Integer> hourlySalesCount; // 시간대별 판매 수량
}
