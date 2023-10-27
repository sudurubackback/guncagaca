package backend.sudurukbackx6.ownerservice.domain.business.repository;

import backend.sudurukbackx6.ownerservice.domain.business.entity.Business;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BusinessRepository extends JpaRepository<Business, Long> {
}
