package com.sudurukbackx6.adminservice.domain.admin.repository;

import com.sudurukbackx6.adminservice.domain.admin.entity.Admin;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AdminRepository extends JpaRepository<Admin, Long> {
    Optional<Admin> findByEmail(String email);
}