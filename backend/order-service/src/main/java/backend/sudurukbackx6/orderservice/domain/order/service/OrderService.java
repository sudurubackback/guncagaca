package backend.sudurukbackx6.orderservice.domain.order.service;

import backend.sudurukbackx6.orderservice.domain.order.dto.OrderRequestDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderResponseDto;
import backend.sudurukbackx6.orderservice.client.OwnerServiceClient;
import backend.sudurukbackx6.orderservice.domain.order.entity.Order;
import backend.sudurukbackx6.orderservice.domain.order.entity.Status;
import backend.sudurukbackx6.orderservice.domain.order.repository.OrderRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.webjars.NotFoundException;

import java.time.LocalDateTime;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional
public class OrderService {

    private final OrderRepository orderRepository;

    public OrderResponseDto addOrder(OrderRequestDto orderRequestDto) {

        // TODO memberId 찾아서 order에 set
        Order newOrder = Order.builder()
                .orderTime(LocalDateTime.now())
                .storeId(orderRequestDto.getStoreId())
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

//    public OrderIndexResponseDto addOrder(OrderRequestDto orderRequestDto) {
//        log.info("before order");
//        OrderIndexResponseDto orderIndexResponseDto = ownerServiceClient.getOrder(orderRequestDto);
//
//        List<Menu> menuList = new ArrayList<>();
//        for (MenuResponseDto menuResponseDto : orderIndexResponseDto.getMenus()) {
//            Menu menu = Menu.builder()
//                    .menuId(menuResponseDto.getMenuId())
//                    .quantity(menuResponseDto.getQuantity())
//                    .option(menuResponseDto.getOptions()).build();
//            menuList.add(menu);
//        }
//
//        Order order = Order.builder()
//                .memberId(orderIndexResponseDto.getMemberId())
//                .storeId(orderIndexResponseDto.getStoreId())
//                .orderTime(LocalDateTime.now())
//                .status(Status.ORDERED)
//                .menus(menuList)
//                .build();
//
//        orderRepository.save(order);
//        log.info("after order");
//        return new OrderIndexResponseDto();

    public Order getOrder(String orderId) {
        return orderRepository.findById(orderId)
                .orElseThrow(() -> new NotFoundException("주문을 찾을 수 없습니다."));

    }
}
