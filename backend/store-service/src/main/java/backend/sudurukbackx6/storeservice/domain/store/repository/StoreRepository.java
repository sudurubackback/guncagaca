package backend.sudurukbackx6.storeservice.domain.store.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import backend.sudurukbackx6.storeservice.domain.store.entity.Store;

public interface StoreRepository extends JpaRepository<Store, Long> {
}
