package backend.sudurukbackx6.orderservice.domain.order.service;

import backend.sudurukbackx6.orderservice.domain.menu.entity.Menu;
import backend.sudurukbackx6.orderservice.domain.order.dto.*;
import backend.sudurukbackx6.orderservice.client.OwnerServiceClient;
import backend.sudurukbackx6.orderservice.domain.order.entity.Order;
import backend.sudurukbackx6.orderservice.domain.order.entity.Status;
import backend.sudurukbackx6.orderservice.domain.order.repository.OrderRepository;
import kr.co.bootpay.Bootpay;
import kr.co.bootpay.model.request.Cancel;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Sort;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.webjars.NotFoundException;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

import java.time.LocalTime;
import java.util.*;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional
public class OrderService {

    private final OrderRepository orderRepository;

    @Value("${bootpay.clientId")
    private String CLIENT_ID;

    @Value("${bootpay.secretKey")
    private String PRIVATE_KEY;

    Bootpay bootpay = new Bootpay(CLIENT_ID, PRIVATE_KEY);

    // 주문 등록
    public OrderResponseDto addOrder(OrderRequestDto orderRequestDto) {

        // TODO memberId 찾아서 order에 set
        Order newOrder = Order.builder()
                .orderTime(LocalDateTime.now())
                .storeId(orderRequestDto.getStoreId())
                .receiptId(orderRequestDto.getReceiptId())
                .status(Status.ORDERED)
                .takeoutYn(orderRequestDto.isTakeoutYn())
                .reviewYn(false)
                .price(orderRequestDto.getTotalOrderPrice())
                .menus(orderRequestDto.getMenus())
                .build();

        orderRepository.save(newOrder);

        OrderResponseDto responseDto = new OrderResponseDto(null, null, orderRequestDto);

        return responseDto;
    }

    @KafkaListener(topics = "reviewTopic", groupId = "order")
    public void updateOrderReviewStatus(@Payload String orderId) {
        Order order = getOrder(orderId);
        if (!order.isReviewYn()) {
            order.setReviewYn(true);
            log.info("작성완료 {}", orderId);
            orderRepository.save(order);
        } else {
            log.info("이미 작성됨 {}", orderId);
        }
    }

    public Order getOrder(String orderId) {
        return orderRepository.findById(orderId)
                .orElseThrow(() -> new NotFoundException("주문을 찾을 수 없습니다."));

    }

    // 결제 취소
    public void cancelPay(String email, String receiptId, String reason) {

        try {
            HashMap<String, Object> token = bootpay.getAccessToken();
            if(token.get("error_code") != null) { //failed
                return;
            }
            Cancel cancel = new Cancel();
            cancel.receiptId = receiptId;
            cancel.cancelMessage = reason;
            cancel.cancelUsername = email;

            HashMap<String, Object> res = bootpay.receiptCancel(cancel);
            if(res.get("error_code") == null) { //success
                log.info("receiptCancel success: " + res);
            } else {
                log.info("receiptCancel false: " + res);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 주문 취소
    public void cancelOrder(String email, OrderCancelRequestDto orderCancelRequestDto) {

        // 결제 취소부터
        cancelPay(email, orderCancelRequestDto.getReceiptId(), orderCancelRequestDto.getReason());

        // 주문 내역 취소로 업데이트
        Order order = getOrder(orderCancelRequestDto.getOrderId());
        order.setStatus(Status.CANCELED);
        orderRepository.save(order);

    }

    // Owner에서 통계용
    // TODO : 가게 별 운영 시간에 맞춰서 작성
    public List<StoreOrderResponse> getStoreOrdersForDateRange(Long storeId, LocalDate startDate, LocalDate endDate) {
        LocalDateTime startOfStartDate = startDate.atStartOfDay(); // 시작 날짜의 시작 시각 (00:00)
        LocalDateTime endOfEndDate = endDate.atTime(LocalTime.MAX); // 종료 날짜의 끝 시각 (23:59:59.999999999)
        System.out.println(startOfStartDate);
        System.out.println(endOfEndDate);
        Sort sort = Sort.by(Sort.Direction.ASC, "orderTime"); // orderTime에 대해 오름차순 정렬

        List<Order> orders = orderRepository.findByStoreIdAndOrderTimeBetween(storeId, startOfStartDate, endOfEndDate, sort);

        List<StoreOrderResponse> storeOrderResponses = new ArrayList<>();
        for (Order order : orders) {
            StoreOrderResponse storeOrderResponse = StoreOrderResponse.builder()
                    .memberId(order.getMemberId())
                    .orderTime(order.getOrderTime())
                    .status(String.valueOf(order.getStatus()))
                    .takeoutYn(order.isTakeoutYn())
                    .menuList(order.getMenus())
                    .price(BigDecimal.valueOf(order.getPrice()))
                    .build();
            storeOrderResponses.add(storeOrderResponse);
        }
        return storeOrderResponses;
    }


    public SalesSummaryResponse getSalesSummary(Long storeId, LocalDate startDate, LocalDate endDate) {
        List<StoreOrderResponse> orders = getStoreOrdersForDateRange(storeId, startDate, endDate);

        BigDecimal totalSales = orders.stream()
                .map(StoreOrderResponse::getPrice)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        Map<String, Integer> menuSalesCount = new HashMap<>();
        Map<Integer, Integer> hourlySalesCount = new HashMap<>();

        for (StoreOrderResponse order : orders) {
            // 시간대별 판매량 계산
            int hour = order.getOrderTime().getHour();
            hourlySalesCount.merge(hour, 1, Integer::sum);

            // 메뉴별 판매량 계산
            for (Menu menu : order.getMenuList()) {
                menuSalesCount.merge(menu.getMenuName(), 1, Integer::sum);
            }
        }

        return new SalesSummaryResponse(totalSales, menuSalesCount, hourlySalesCount);
    }


}
