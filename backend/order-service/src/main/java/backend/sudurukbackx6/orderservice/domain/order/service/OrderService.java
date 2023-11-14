package backend.sudurukbackx6.orderservice.domain.order.service;

import backend.sudurukbackx6.orderservice.client.MemberServiceClient;
import backend.sudurukbackx6.orderservice.client.StoreServiceClient;
import backend.sudurukbackx6.orderservice.config.KafkaEventService;
import backend.sudurukbackx6.orderservice.domain.menu.entity.Menu;
import backend.sudurukbackx6.orderservice.domain.order.dto.*;
import backend.sudurukbackx6.orderservice.domain.order.dto.response.OrderListResDto;
import backend.sudurukbackx6.orderservice.client.OwnerServiceClient;
import backend.sudurukbackx6.orderservice.domain.order.entity.Order;
import backend.sudurukbackx6.orderservice.domain.order.entity.Status;
import backend.sudurukbackx6.orderservice.domain.order.repository.OrderRepository;
import com.fasterxml.jackson.core.JsonProcessingException;
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
    private final MemberServiceClient memberServiceClient;
    private final KafkaEventService kafkaEventService;
    private final StoreServiceClient storeServiceClient;
    private final SseService sseService;

    @Value("${bootpay.clientId}")
    private String CLIENT_ID;

    @Value("${bootpay.secretKey}")
    private String PRIVATE_KEY;


    // 주문 등록
    public OrderResponseDto addOrder(String email, OrderRequestDto orderRequestDto) {
        Long memberId = memberServiceClient.getId(email);

        Order newOrder = Order.builder()
                .orderTime(LocalDateTime.now())
                .memberId(memberId)
                .storeId(orderRequestDto.getStoreId())
                .receiptId(orderRequestDto.getReceiptId())
                .status(Status.ORDERED)
                .takeoutYn(orderRequestDto.isTakeoutYn())
                .reviewYn(false)
                .payMethod(orderRequestDto.getPayMethod())
                .eta(orderRequestDto.getEta())
                .price(orderRequestDto.getTotalOrderPrice())
                .menus(orderRequestDto.getMenus())
                .build();

        orderRepository.save(newOrder);

        // storeId 가진 클라이언트에 SSE이벤트 발송
        sseService.sendToStoreClients(orderRequestDto.getStoreId(), newOrder);

        OrderResponseDto responseDto = new OrderResponseDto(memberId, orderRequestDto.getStoreId(), orderRequestDto);

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
    @Transactional
    public boolean cancelPay(String email, String receiptId, String reason) {
        try {
            Bootpay bootpay = new Bootpay(CLIENT_ID, PRIVATE_KEY);

            log.info("부트페이 호출");
            HashMap<String, Object> token = bootpay.getAccessToken();
            if(token.get("error_code") != null) { //failed
                return false;
            }
            log.info("token획득");
            Cancel cancel = new Cancel();
            cancel.receiptId = receiptId;
            cancel.cancelMessage = reason;
            cancel.cancelUsername = email;

            log.info("취소생성");
            HashMap<String, Object> res = bootpay.receiptCancel(cancel);
            if(res.get("error_code") == null) { //success
                log.info("receiptCancel success: " + res);
                return true;
            } else {
                log.info("receiptCancel false: " + res);
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 주문 취소
    @Transactional
    public boolean cancelOrder(String email, OrderCancelRequestDto orderCancelRequestDto) throws JsonProcessingException {

        // 결제 취소부터
        if (cancelPay(email, orderCancelRequestDto.getReceiptId(), orderCancelRequestDto.getReason())) {
            // 주문 내역 취소로 업데이트
            Order order = getOrder(orderCancelRequestDto.getOrderId());
            Long memberId = order.getMemberId();
            order.setStatus(Status.CANCELED);
            orderRepository.save(order);

            String orderMenu = null;
            List<Menu> menus = order.getMenus();
            if (menus != null && !menus.isEmpty()) {
                if (menus.size() > 1) {
                    orderMenu = menus.get(0).getMenuName() + " 외 " + (menus.size() - 1) + "개";
                } else {
                    orderMenu = menus.get(0).getMenuName();
                }
            }
            publishOrderEvent(email, memberId, Status.COMPLETE, order.getStoreId(), null, orderMenu);

            return true;
        }
        return false;
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

    public List<Order> getOrdersByStoreId(Long storeId) {
//        List<OrderListResDto> orderResponseDtos = new ArrayList<>();
//        List<Order> orders = orderRepository.findByStoreIdAndStatus(storeId, Status.ORDERED);
//        for(Order order : orders) {
//            OrderListResDto orderResponseDto = new OrderListResDto(order);
//            orderResponseDtos.add(orderResponseDto);
//        }
//        return orderResponseDtos;
        return orderRepository.findByStoreIdAndStatusOrderByOrderTimeDesc(storeId, Status.ORDERED);
    }

    public List<Order> getDoneByStoreId(Long storeId) {
//        List<OrderListResDto> orderResponseDtos = new ArrayList<>();
//        List<Order> orders = orderRepository.findByStoreIdAndStatus(storeId, Status.COMPLETE);
//        for(Order order : orders) {
//            OrderListResDto orderResponseDto = new OrderListResDto(order);
//            orderResponseDtos.add(orderResponseDto);
//        }
//
//        return orderResponseDtos;
        return orderRepository.findByStoreIdAndStatusOrderByOrderTimeDesc(storeId, Status.COMPLETE);
    }

    public List<Order> getPreparingByStoreId(Long storeId) {
//        List<OrderListResDto> orderResponseDtos = new ArrayList<>();
//        List<Order> orders = orderRepository.findByStoreIdAndStatus(storeId, Status.REQUEST);
//        for(Order order : orders) {
//            OrderListResDto orderResponseDto = new OrderListResDto(order);
//            orderResponseDtos.add(orderResponseDto);
//        }
//        return orderResponseDtos;
        return orderRepository.findByStoreIdAndStatusOrderByOrderTimeDesc(storeId, Status.REQUEST);
    }

    public List<Order> getCancleByStoreId(Long storeId) {
//        List<OrderListResDto> orderResponseDtos = new ArrayList<>();
//        List<Order> orders = orderRepository.findByStoreIdAndStatus(storeId, Status.CANCELED);
//        for(Order order : orders) {
//            OrderListResDto orderResponseDto = new OrderListResDto(order);
//            orderResponseDtos.add(orderResponseDto);
//        }
//        return orderResponseDtos;
        return orderRepository.findByStoreIdAndStatusOrderByOrderTimeDesc(storeId, Status.CANCELED);
    }

    public List<Order> getOrdersByDateTime(Long storeId, LocalDateTime startTime, LocalDateTime endTime) {

        return orderRepository.findByStoreIdAndOrderTimeBetweenOrderByOrderTimeDesc(storeId, startTime, endTime);
    }


    public String requestOrder (String email, String obejctId) throws JsonProcessingException {
        Order order = orderRepository.findById(obejctId)
                .orElseThrow(() -> new IllegalArgumentException("주문을 찾을 수 없습니다."));

        Long memberId = order.getMemberId();
        log.info(memberId.toString());

        order.setStatus(Status.REQUEST);
        orderRepository.save(order);

        String orderMenu = null;
        List<Menu> menus = order.getMenus();
        if (menus != null && !menus.isEmpty()) {
            if (menus.size() > 1) {
                orderMenu = menus.get(0).getMenuName() + " 외 " + (menus.size() - 1) + "개";
            } else {
                orderMenu = menus.get(0).getMenuName();
            }
        }
        publishOrderEvent(email, memberId, Status.COMPLETE, order.getStoreId(), null, orderMenu);

        return "주문 접수가 완료되었습니다.";
    }

    public String completeOrder (String email, String obejctId) throws JsonProcessingException {
        Order order = orderRepository.findById(obejctId)
                .orElseThrow(() -> new IllegalArgumentException("주문을 찾을 수 없습니다."));

        Long memberId = order.getMemberId();
        log.info(memberId.toString());

        order.setStatus(Status.COMPLETE);
        orderRepository.save(order);

        String orderMenu = null;
        List<Menu> menus = order.getMenus();
        if (menus != null && !menus.isEmpty()) {
            if (menus.size() > 1) {
                orderMenu = menus.get(0).getMenuName() + " 외 " + (menus.size() - 1) + "개";
            } else {
                orderMenu = menus.get(0).getMenuName();
            }
        }
        publishOrderEvent(email, memberId, Status.COMPLETE, order.getStoreId(), null, orderMenu);

        return "주문 상품이 완료되었습니다.";
    }

    // 주문 상태 변경 이벤트 발행
    public void publishOrderEvent(String email, Long memberId, Status status, Long storeId, String reason, String orderMenu) throws JsonProcessingException {

        String storeName = storeServiceClient.getStore(email, storeId).getCafeName();
        OrderEvent orderEvent = new OrderEvent(memberId, status, storeId, storeName, reason, orderMenu);

        kafkaEventService.eventPublish("orderNotification", orderEvent);
    }

    public List<Order> getMemberOrder(String email) {
        Long memberId = memberServiceClient.getId(email);
        List<Order> orderList = orderRepository.findAllByMemberIdOrderByOrderTimeDesc(memberId);
        return orderList;
    }

    public List<Order> getMemberStoreOrder(String email, Long storeId) {
        Long memberId = memberServiceClient.getId(email);
        List<Order> orderList = orderRepository.findByMemberIdAndStoreIdOrderByOrderTimeDesc(memberId, storeId);
        return orderList;
    }

}
