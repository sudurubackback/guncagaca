package backend.sudurukbackx6.orderservice.domain.order.service;

import backend.sudurukbackx6.orderservice.client.OwnerServiceClient;
import backend.sudurukbackx6.orderservice.domain.order.dto.MenuResponseDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderRequestDto;
import backend.sudurukbackx6.orderservice.domain.order.dto.OrderIndexResponseDto;
import backend.sudurukbackx6.orderservice.domain.order.entity.Menu;
import backend.sudurukbackx6.orderservice.domain.order.entity.Order;
import backend.sudurukbackx6.orderservice.domain.order.entity.Status;
import backend.sudurukbackx6.orderservice.domain.order.repository.OrderRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class OrderService {
    private final OwnerServiceClient ownerServiceClient;
    private final OrderRepository orderRepository;

    public OrderIndexResponseDto addOrder(OrderRequestDto orderRequestDto) {
        log.info("before order");
        OrderIndexResponseDto orderIndexResponseDto = ownerServiceClient.getOrder(orderRequestDto);

        List<Menu> menuList = new ArrayList<>();
        for (MenuResponseDto menuResponseDto : orderIndexResponseDto.getMenus()) {
            Menu menu = Menu.builder()
                    .menuId(menuResponseDto.getMenuId())
                    .quantity(menuResponseDto.getQuantity())
                    .option(menuResponseDto.getOptions()).build();
            menuList.add(menu);
        }

        Order order = Order.builder()
                .memberId(orderIndexResponseDto.getMemberId())
                .storeId(orderIndexResponseDto.getStoreId())
                .orderTime(LocalDateTime.now())
                .status(Status.ORDERED)
                .menus(menuList)
                .build();

        orderRepository.save(order);
        log.info("after order");
        return new OrderIndexResponseDto();
    }

}
