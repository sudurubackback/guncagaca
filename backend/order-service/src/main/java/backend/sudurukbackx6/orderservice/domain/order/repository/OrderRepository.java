package backend.sudurukbackx6.orderservice.domain.order.repository;

import backend.sudurukbackx6.orderservice.domain.order.entity.Order;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface OrderRepository extends MongoRepository<Order, String> {
    List<Order> findAllByMemberIdOrderByOrderTimeDesc(Long memberId);
}
