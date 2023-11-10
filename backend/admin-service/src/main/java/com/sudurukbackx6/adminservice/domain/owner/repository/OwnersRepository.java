package com.sudurukbackx6.adminservice.domain.owner.repository;


import com.sudurukbackx6.adminservice.domain.owner.entity.Owners;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface OwnersRepository extends JpaRepository<Owners, Long> {

    Optional<Owners> findByEmail(String email);
//    Owners findByEmail(String email);
    void deleteByEmail(String email);


}
