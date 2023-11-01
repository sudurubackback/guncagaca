package backend.sudurukbackx6.orderservice.domain.order.service;

import backend.sudurukbackx6.orderservice.domain.order.dto.OrderRequestDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderResponseDto;
import backend.sudurukbackx6.orderservice.client.OwnerServiceClient;
import backend.sudurukbackx6.orderservice.domain.order.dto.StoreOrderResponse;
import backend.sudurukbackx6.orderservice.domain.order.entity.Order;
import backend.sudurukbackx6.orderservice.domain.order.entity.Status;
import backend.sudurukbackx6.orderservice.domain.order.repository.OrderRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Service
@RequiredArgsConstructor
@Slf4j
public class OrderService {

    private final OrderRepository orderRepository;

    public OrderResponseDto addOrder(OrderRequestDto orderRequestDto) {

        // TODO memberId 찾아서 order에 set
        Order newOrder = Order.builder()
                .orderTime(LocalDateTime.now())
                .storeId(orderRequestDto.getStoreId())
                .status(Status.ORDERED)
                .takeoutYn(orderRequestDto.isTakeoutYn())
                .price(orderRequestDto.getTotalOrderPrice())
                .menus(orderRequestDto.getMenus())
                .build();

        orderRepository.save(newOrder);

        OrderResponseDto responseDto = new OrderResponseDto(null, null, orderRequestDto);

        return responseDto;

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
}
