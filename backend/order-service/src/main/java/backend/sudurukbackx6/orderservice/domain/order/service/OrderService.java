package backend.sudurukbackx6.orderservice.domain.order.service;

import backend.sudurukbackx6.orderservice.domain.order.dto.OrderCancelRequestDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderRequestDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderResponseDto;
import backend.sudurukbackx6.orderservice.client.OwnerServiceClient;
import backend.sudurukbackx6.orderservice.domain.order.dto.StoreOrderResponse;
import backend.sudurukbackx6.orderservice.domain.order.entity.Order;
import backend.sudurukbackx6.orderservice.domain.order.entity.Status;
import backend.sudurukbackx6.orderservice.domain.order.repository.OrderRepository;
import kr.co.bootpay.Bootpay;
import kr.co.bootpay.model.request.Cancel;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.webjars.NotFoundException;

import java.time.LocalDateTime;

import java.util.HashMap;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

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

        OrderResponseDto responseDto = new OrderResponseDto(orderRequestDto.getMemberId(), orderRequestDto.getStoreId(), orderRequestDto);

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
    public List<StoreOrderResponse> getStoredOrder (Long storeId){

        List<StoreOrderResponse> storeOrderResponses = new ArrayList<>();

        List<Order> all = orderRepository.findAll();
        for (Order order : all) {
            if(Objects.equals(order.getStoreId(), storeId)){
                StoreOrderResponse storeOrderResponse = StoreOrderResponse.builder()
                        .memberId(order.getMemberId())
                        .orderTime(order.getOrderTime())
                        .status(order.getStatus())
                        .takeoutYn(order.isTakeoutYn())
                        .menuList(order.getMenus())
                        .price(order.getPrice())
                        .build();
                storeOrderResponses.add(storeOrderResponse);
            }
        }

        return storeOrderResponses;
    }

    public String requestOrder (String obejctId) {
        Order order = orderRepository.findById(obejctId)
                .orElseThrow(() -> new IllegalArgumentException("주문을 찾을 수 없습니다."));
        order.updateStatus(Status.REQUEST);

        // TODO 알림보내기

        return "주문 접수가 완료되었습니다.";
    }
}
