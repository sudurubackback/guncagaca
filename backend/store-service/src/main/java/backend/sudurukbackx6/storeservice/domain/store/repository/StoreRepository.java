package backend.sudurukbackx6.storeservice.domain.store.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import backend.sudurukbackx6.storeservice.domain.store.entity.Store;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

public interface StoreRepository extends JpaRepository<Store, Long> {

    @Modifying
    @Transactional
    @Query("UPDATE Store s SET s.starPoint = :point WHERE s.id = :storeId")
    void updateStarPoint(@Param("point") Double point, @Param("storeId") Long storeId);
}
