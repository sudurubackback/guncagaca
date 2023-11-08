package backend.sudurukbackx6.ownerservice.domain.owner.repository;

import backend.sudurukbackx6.ownerservice.domain.owner.client.dto.StoreOrderResponse;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.GetTodaySellingResponse;
import backend.sudurukbackx6.ownerservice.domain.owner.entity.Owners;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface OwnersRepository extends JpaRepository<Owners, Long> {

    Optional<Owners> findByEmail(String email);
    void deleteByEmail(String email);

//    @Query("select o from StoreOrderResponse where")
//    List<GetTodaySellingResponse> getTodaySelling (@Param("date") LocalDateTime date, );

}
