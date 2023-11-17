package backend.sudurukbackx6.ownerservice.domain.owner.service;

import backend.sudurukbackx6.ownerservice.domain.order.entity.Order;
import backend.sudurukbackx6.ownerservice.domain.owner.client.dto.SalesSummaryResponse;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.StoreOrderResponse;
//import backend.sudurukbackx6.ownerservice.domain.owner.repository.OwnerStatisticsRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@RequiredArgsConstructor
@Transactional
@Service
public class OwnerStatisticsService {

//    private final OwnerStatisticsRepository ownerStatisticsRepository;

    // Owner에서 통계용
    // TODO : 가게 별 운영 시간에 맞춰서 작성
//    public List<StoreOrderResponse> getStoreOrdersForDateRange(Long storeId, LocalDate startDate, LocalDate endDate) {
//        LocalDateTime startOfStartDate = startDate.atStartOfDay(); // 시작 날짜의 시작 시각 (00:00)
//        LocalDateTime endOfEndDate = endDate.atTime(LocalTime.MAX); // 종료 날짜의 끝 시각 (23:59:59.999999999)
//        System.out.println(startOfStartDate);
//        System.out.println(endOfEndDate);
//        Sort sort = Sort.by(Sort.Direction.ASC, "orderTime"); // orderTime에 대해 오름차순 정렬
//
//        List<Order> orders = ownerStatisticsRepository.findByStoreIdAndOrderTimeBetween(storeId, startOfStartDate, endOfEndDate, sort);
//
//        List<StoreOrderResponse> storeOrderResponses = new ArrayList<>();
//        for (Order order : orders) {
//            List<StoreOrderResponse.Menu> menuList = order.getMenus().stream()
//                    .map(menu -> StoreOrderResponse.Menu.builder()
//                            .menuId(menu.getMenuId())
//                            .menuName(menu.getMenuName())
//                            .price(menu.getPrice())
//                            .totalPrice(menu.getTotalPrice())
//                            .quantity(menu.getQuantity())
//                            .img(menu.getImg())
//                            .category(menu.getCategory())
//                            .options(menu.getOptions().stream()
//                                    .map(option -> StoreOrderResponse.Menu.Option.builder()
//                                            .optionName(option.getOptionName())
//                                            .selectedOption(option.getSelectedOption())
//                                            .build())
//                                    .collect(Collectors.toList()))
//                            .build())
//                    .collect(Collectors.toList());
//
//            StoreOrderResponse storeOrderResponse = StoreOrderResponse.builder()
//                    .memberId(order.getMemberId())
//                    .orderTime(order.getOrderTime())
//                    .status(String.valueOf(order.getStatus()))
//                    .takeoutYn(order.isTakeoutYn())
//                    .menuList(menuList)
//                    .price(order.getPrice())
//                    .build();
//
//            storeOrderResponses.add(storeOrderResponse); // storeOrderResponse를 리스트에 추가
//        }
//        return storeOrderResponses; // 리스트 반환
//    }
//
//    public backend.sudurukbackx6.ownerservice.domain.owner.dto.SalesSummaryResponse getSalesSummary(Long storeId, LocalDate startDate, LocalDate endDate) {
//        List<StoreOrderResponse> orders = getStoreOrdersForDateRange(storeId, startDate, endDate);
//
//        BigDecimal totalSales = orders.stream()
//                .map(order -> BigDecimal.valueOf(order.getPrice()))
//                .reduce(BigDecimal.ZERO, BigDecimal::add);
//
//        Map<String, Integer> menuSalesCount = new HashMap<>();
//        Map<Integer, Integer> hourlySalesCount = new HashMap<>();
//
//        for (StoreOrderResponse order : orders) {
//            // 시간대별 판매량 계산
//            int hour = order.getOrderTime().getHour();
//            hourlySalesCount.merge(hour, 1, Integer::sum);
//
//            // 메뉴별 판매량 계산
//            for (StoreOrderResponse.Menu menu : order.getMenuList()) {
//                menuSalesCount.merge(menu.getMenuName(), 1, Integer::sum);
//            }
//        }
//
//        return new backend.sudurukbackx6.ownerservice.domain.owner.dto.SalesSummaryResponse(totalSales, menuSalesCount, hourlySalesCount);
//    }
}
