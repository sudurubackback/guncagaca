package backend.sudurukbackx6.ownerservice.domain.menu.repository;

import org.springframework.data.mongodb.repository.MongoRepository;

import backend.sudurukbackx6.ownerservice.domain.menu.entity.MenuEntity;

import java.util.List;

public interface MenuRepository extends MongoRepository<MenuEntity, String> {

    List<MenuEntity> findByStoreId(Long storeId);
}