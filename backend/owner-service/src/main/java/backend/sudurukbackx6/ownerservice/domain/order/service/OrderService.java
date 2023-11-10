package backend.sudurukbackx6.ownerservice.domain.order.service;

import backend.sudurukbackx6.ownerservice.domain.menu.entity.enumTypes.Status;
import backend.sudurukbackx6.ownerservice.domain.order.entity.Order;
import backend.sudurukbackx6.ownerservice.domain.order.repository.OrderRepository;
import backend.sudurukbackx6.ownerservice.domain.order.dto.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.webjars.NotFoundException;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional
public class OrderService {

    private final OrderRepository orderRepository;

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
    public boolean cancelOrder(String email, OrderCancelRequestDto orderCancelRequestDto) {

        // 결제 취소부터
        if (cancelPay(email, orderCancelRequestDto.getReceiptId(), orderCancelRequestDto.getReason())) {
            // 주문 내역 취소로 업데이트
            Order order = getOrder(orderCancelRequestDto.getOrderId());
            order.setStatus(Status.CANCELED);
            orderRepository.save(order);
            return true;
        }
        return false;
    }

    // owner 통계용
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

    // 주문 대기 목록 리스트
    public List<OrderListResDto> getOrdersByStoreId(Long storeId) {
        List<OrderListResDto> orderResponseDtos = new ArrayList<>();
        List<Order> orders = orderRepository.findByStoreIdAndStatus(storeId, Status.ORDERED);
        for(Order order : orders) {
            OrderListResDto orderResponseDto = new OrderListResDto(order);
            orderResponseDtos.add(orderResponseDto);
        }
        return orderResponseDtos;
    }

    // 주문 처리중 목록 리스트
    public List<OrderListResDto> getPreparingByStoreId(Long storeId) {
        List<OrderListResDto> orderResponseDtos = new ArrayList<>();
        List<Order> orders = orderRepository.findByStoreIdAndStatus(storeId, Status.REQUEST);
        for(Order order : orders) {
            OrderListResDto orderResponseDto = new OrderListResDto(order);
            orderResponseDtos.add(orderResponseDto);
        }
        return orderResponseDtos;
    }

    // 주문 완료 목록 리스트
    public List<OrderListResDto> getDoneByStoreId(Long memberId) {
        List<OrderListResDto> orderResponseDtos = new ArrayList<>();
        List<Order> orders = orderRepository.findByStoreIdAndStatus(memberId, Status.COMPLETE);
        for(Order order : orders) {
            OrderListResDto orderResponseDto = new OrderListResDto(order);
            orderResponseDtos.add(orderResponseDto);
        }

        return orderResponseDtos;
    }

    // 주문 취소 목록 리스트
    public List<OrderListResDto> getCancleByStoreId(Long storeId) {
        List<OrderListResDto> orderResponseDtos = new ArrayList<>();
        List<Order> orders = orderRepository.findByStoreIdAndStatus(storeId, Status.CANCELED);
        for(Order order : orders) {
            OrderListResDto orderResponseDto = new OrderListResDto(order);
            orderResponseDtos.add(orderResponseDto);
        }
        return orderResponseDtos;
    }

    // 주문 접수 알림 보내기
    public String requestOrder (String email, String obejctId) {
        Order order = orderRepository.findById(obejctId)
                .orElseThrow(() -> new IllegalArgumentException("주문을 찾을 수 없습니다."));
        Long memberId = memberServiceClient.getId(email);
        log.info(memberId.toString());

        order.setStatus(Status.REQUEST);
        orderRepository.save(order);
        // TODO 알림보내기 (Open Feign)

        return "주문 접수가 완료되었습니다.";
    }

    // 주문 완료 알림 보내기
    public String completeOrder (String email, String obejctId) {
        Order order = orderRepository.findById(obejctId)
                .orElseThrow(() -> new IllegalArgumentException("주문을 찾을 수 없습니다."));
        Long memberId = memberServiceClient.getId(email);
        log.info(memberId.toString());

        order.setStatus(Status.COMPLETE);
        orderRepository.save(order);
        // TODO 알림보내기 TODO 알림보내기 (Open Feign)

        return "주문 상품이 완료되었습니다.";
    }
}
