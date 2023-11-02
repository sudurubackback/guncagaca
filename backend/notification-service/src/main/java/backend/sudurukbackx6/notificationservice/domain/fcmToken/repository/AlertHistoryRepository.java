package backend.sudurukbackx6.notificationservice.domain.fcmToken.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import backend.sudurukbackx6.notificationservice.domain.fcmToken.entity.AlertHistory;

public interface AlertHistoryRepository extends JpaRepository<AlertHistory, Long> {
}
