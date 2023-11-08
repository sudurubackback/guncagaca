package backend.sudurukbackx6.notificationservice.domain.fcmToken.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import backend.sudurukbackx6.notificationservice.domain.fcmToken.entity.AlertHistory;

import java.util.List;

public interface AlertHistoryRepository extends JpaRepository<AlertHistory, Long> {
    List<AlertHistory> findAllByMemberIdOrderByCreateTimeDesc(Long memberId);
}
