package backend.sudurukbackx6.ownerservice.domain.order.repository;

import backend.sudurukbackx6.ownerservice.domain.order.entity.Order;
import backend.sudurukbackx6.ownerservice.domain.menu.entity.enumTypes.Status;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface OrderRepository extends MongoRepository<Order, String> {
    List<Order> findByStoreIdAndStatus(Long storeId, Status status);
}
