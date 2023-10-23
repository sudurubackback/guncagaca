package backend.sudurukbackx6.ownerservice.domain.owner.repository;

import backend.sudurukbackx6.ownerservice.domain.owner.entity.Owners;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface OwnersRepository extends JpaRepository<Owners, Long> {

    Optional<Owners> findByEmail(String email);
    void deleteByEmail(String email);
}
