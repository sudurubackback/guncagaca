package backend.sudurukbackx6.orderservice.domain.order.service;

import backend.sudurukbackx6.orderservice.domain.order.dto.OrderCancelRequestDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderRequestDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderResponseDto;
import backend.sudurukbackx6.orderservice.domain.order.entity.Order;
import backend.sudurukbackx6.orderservice.domain.order.entity.Status;
import backend.sudurukbackx6.orderservice.domain.order.repository.OrderRepository;
import kr.co.bootpay.Bootpay;
import kr.co.bootpay.model.request.Cancel;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.webjars.NotFoundException;

import java.time.LocalDateTime;

import java.util.HashMap;

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
                .price(orderRequestDto.getTotalOrderPrice())
                .menus(orderRequestDto.getMenus())
                .build();

        orderRepository.save(newOrder);

        OrderResponseDto responseDto = new OrderResponseDto(null, null, orderRequestDto);

        return responseDto;
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

    public Order getOrder(String orderId) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new NotFoundException("주문을 찾을 수 없습니다."));
        return order;
    }

}
