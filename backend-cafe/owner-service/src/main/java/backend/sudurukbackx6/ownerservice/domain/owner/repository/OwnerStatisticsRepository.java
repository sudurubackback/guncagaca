package backend.sudurukbackx6.ownerservice.domain.owner.repository;

import backend.sudurukbackx6.ownerservice.domain.order.entity.Order;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;

public interface OwnerStatisticsRepository extends JpaRepository<Order,Long> {

    List<Order> findByStoreIdAndOrderTimeBetween(
            Long storeId, LocalDateTime startOfStartDate, LocalDateTime endOfEndDate, Sort sort
    );
}
