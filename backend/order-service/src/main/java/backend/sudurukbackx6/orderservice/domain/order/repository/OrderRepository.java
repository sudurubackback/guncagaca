package backend.sudurukbackx6.orderservice.domain.order.repository;

import backend.sudurukbackx6.orderservice.domain.order.entity.Order;
import backend.sudurukbackx6.orderservice.domain.order.entity.Status;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface OrderRepository extends MongoRepository<Order, String> {

    

    List<Order> findAllByMemberIdOrderByOrderTimeDesc(Long memberId);

    List<Order> findByMemberIdAndStoreIdOrderByOrderTimeDesc(Long memberId, Long storeId);
    List<Order> findByStoreIdAndStatus(Long storeId, Status status);
    // 주문 상태별 주문 조회
    List<Order> findByStoreIdAndStatusOrderByOrderTimeDesc(Long storeId, Status status);
    // 기간별 주문 조회
    List<Order> findByStoreIdAndOrderTimeBetweenOrderByOrderTimeDesc(Long storeId, LocalDateTime  startDate, LocalDateTime  endDate);
}

