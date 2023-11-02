package backend.sudurukbackx6.ownerservice.domain.owner.service;

import backend.sudurukbackx6.ownerservice.domain.owner.client.OrderServiceClient;
import backend.sudurukbackx6.ownerservice.domain.owner.client.dto.StoreOrderResponse;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.GetTodaySellingResponse;
import backend.sudurukbackx6.ownerservice.domain.owner.repository.OwnersRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Transactional
@Service
public class OwnerStatisticsService {

    private final OrderServiceClient orderServiceClient;

    // 오늘 시간별 주문 건수 및 돈 총합
    public List<GetTodaySellingResponse> getTodaySelling(Long storeId) {
        List<GetTodaySellingResponse> result = new ArrayList<>();
        List<StoreOrderResponse> storedOrder = orderServiceClient.getStoredOrder(storeId);
        System.out.println(storedOrder + " storedOrder");
        for (StoreOrderResponse storeOrderResponse : storedOrder) {
            LocalDateTime orderTime = storeOrderResponse.getOrderTime();
            System.out.println(orderTime);
        }
        return result;
    }

    // 오늘 시간별 디테일 주문 종류 돈 총합

    // 월 별 주문 건 수 돈 총합

}
