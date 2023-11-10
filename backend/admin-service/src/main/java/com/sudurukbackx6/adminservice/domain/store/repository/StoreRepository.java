package com.sudurukbackx6.adminservice.domain.store.repository;

import com.sudurukbackx6.adminservice.domain.store.entity.Store;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

public interface StoreRepository extends JpaRepository<Store, Long> {

    @Modifying
    @Transactional
    @Query("UPDATE Store s SET s.starPoint = :point WHERE s.id = :storeId")
    void updateStarPoint(@Param("point") Double point, @Param("storeId") Long storeId);

    @Modifying
    @Transactional
    @Query("UPDATE Store s SET s.description = :description, s.closeTime = :closeTime, s.openTime = :openTime, s.img = :img WHERE s.id = :storeId")
    void updateStoreInfo(@Param("description") String description, @Param("closeTime") String closeTime, @Param("openTime") String openTime, @Param("img") String img, @Param("storeId") Long storeId);
}
