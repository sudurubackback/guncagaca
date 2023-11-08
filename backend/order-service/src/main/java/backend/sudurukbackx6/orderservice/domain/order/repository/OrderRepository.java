package backend.sudurukbackx6.orderservice.domain.order.repository;

import backend.sudurukbackx6.orderservice.domain.order.entity.Order;
import backend.sudurukbackx6.orderservice.domain.order.entity.Status;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import java.time.LocalDateTime;
import java.util.List;

import java.util.List;

public interface OrderRepository extends MongoRepository<Order, String> {

    

    List<Order> findAllByMemberIdOrderByOrderTimeDesc(Long memberId);

    List<Order> findByMemberIdAndStoreIdOrderByOrderTimeDesc(Long memberId, Long storeId);


}

