package backend.sudurukbackx6.notificationservice.domain.fcmToken.controller;

import backend.sudurukbackx6.notificationservice.domain.fcmToken.service.AlertHistoryService;
import backend.sudurukbackx6.notificationservice.domain.fcmToken.service.dto.AlertHistoryDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/alert")
@RequiredArgsConstructor
public class AlertHistoryController {
	private final AlertHistoryService alertHistoryService;


	// 알림 목록 조회
	@GetMapping("/history")
	public ResponseEntity<List<AlertHistoryDto>> getAlertHistory(@RequestHeader("Email") String email) {
		return ResponseEntity.ok(alertHistoryService.getAlertHistory(email));
	}

	// 알림 단일 삭제
	@DeleteMapping("/history/{alertId}")
	public ResponseEntity<String> deleteAlertHistory(@RequestHeader("Email") String email, @PathVariable Long alertId) {
		alertHistoryService.deleteAlertHistory(email, alertId);
		return ResponseEntity.ok(String.format("%d번 알림 삭제", alertId));
	}
}
