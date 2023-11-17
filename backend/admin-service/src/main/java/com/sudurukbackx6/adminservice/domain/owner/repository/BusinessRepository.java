package com.sudurukbackx6.adminservice.domain.owner.repository;

import com.sudurukbackx6.adminservice.domain.owner.entity.Business;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BusinessRepository extends JpaRepository<Business, Long> {
    List<Business> findByApprovalFalse();
    List<Business> findByApprovalTrue();
}
