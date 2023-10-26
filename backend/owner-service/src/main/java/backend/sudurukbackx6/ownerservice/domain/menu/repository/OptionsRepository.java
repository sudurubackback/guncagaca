package backend.sudurukbackx6.ownerservice.domain.menu.repository;

import org.springframework.data.mongodb.repository.MongoRepository;

import backend.sudurukbackx6.ownerservice.domain.menu.entity.OptionsEntity;

public interface OptionsRepository extends MongoRepository<OptionsEntity, String> {
}
