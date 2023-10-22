package backend.sudurukbackx6.ownerservice.domain.owner.repository;

import backend.sudurukbackx6.ownerservice.domain.owner.entity.Owners;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OwnersRepository extends JpaRepository<Owners, Long> {
}
