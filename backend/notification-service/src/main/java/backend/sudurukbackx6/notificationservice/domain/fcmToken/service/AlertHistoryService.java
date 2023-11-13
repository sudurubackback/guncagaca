package backend.sudurukbackx6.notificationservice.domain.fcmToken.service;

import backend.sudurukbackx6.notificationservice.domain.fcmToken.client.MemberFeignClient;
import backend.sudurukbackx6.notificationservice.domain.fcmToken.client.dto.response.MemberInfoResponse;
import backend.sudurukbackx6.notificationservice.domain.fcmToken.service.dto.AlertHistoryDto;
import backend.sudurukbackx6.notificationservice.domain.fcmToken.entity.AlertHistory;
import backend.sudurukbackx6.notificationservice.domain.fcmToken.repository.AlertHistoryRepository;
import backend.sudurukbackx6.notificationservice.domain.fcmToken.service.dto.NotificationDto;
import backend.sudurukbackx6.notificationservice.domain.fcmToken.service.dto.NotificationEvent;
import com.google.firebase.messaging.Notification;
import lombok.RequiredArgsConstructor;
import org.springframework.expression.ExpressionException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AlertHistoryService {
	private final AlertHistoryRepository alertHistoryRepository;
	private final MemberFeignClient memberFeignClient;

	// 알림 기록 생성
	public void saveAlertHistory(NotificationEvent notificationEvent, NotificationDto notificationDto) {

		// 알림 내역 저장
		AlertHistory alertHistory = AlertHistory.builder()
				.title(notificationDto.getTitle())
				.body(notificationDto.getBody())
				.memberId(notificationEvent.getMemberId())
				.storeId(notificationEvent.getStoreId())
				.build();

		alertHistoryRepository.save(alertHistory);
	}

	// 알림 목록 조회
	public List<AlertHistoryDto> getAlertHistory(String email) {
		MemberInfoResponse memberInfo = memberFeignClient.getMemberInfo(email);
		Long myId = memberInfo.getId();
		List<AlertHistory> alertHistories = alertHistoryRepository.findAllByMemberIdOrderByCreateTimeDesc(myId);

		List<AlertHistoryDto> alertHistoryDtos = new ArrayList<>();

		for (AlertHistory alertHistory : alertHistories) {
			AlertHistoryDto alertHistoryDto = AlertHistoryDto.builder()
					.alertId(alertHistory.getId())
					.title(alertHistory.getTitle())
					.body(alertHistory.getBody())
					.build();

			alertHistoryDtos.add(alertHistoryDto);
		}
		return alertHistoryDtos;
	}

	// 알림 삭제
	public void deleteAlertHistory(String email, Long alertId) {
		MemberInfoResponse memberInfo = memberFeignClient.getMemberInfo(email);
		Long memberId = memberInfo.getId();

		// 알림 기록 가져오기
		AlertHistory alertHistory = alertHistoryRepository.findById(alertId)
				.orElseThrow(() -> new RuntimeException("해당 알림 기록을 찾을 수 없습니다."));

		// 본인 아닌경우
		if (!alertHistory.getMemberId().equals(memberId)) {
			throw new RuntimeException("해당 알림을 삭제할 권한이 없습니다.");
		}

		// 삭제
		alertHistoryRepository.delete(alertHistory);
	}

//	// 알림 전체 삭제
//	public void deleteAllAlertHistory(Long memberId) {
//		// 현재 유저 알림 목록
//		Member member = memberRepository.findById(memberId)
//			.orElseThrow(() -> new BusinessException(ErrorCode.NOT_EXISTS_USER_ID));
//		List<AlertHistory> alertHistories = alertHistoryRepository.findAllByMemberOrderByCreateTimeDesc(member);
//
//		// 삭제
//		alertHistoryRepository.deleteAll(alertHistories);
//	}
}
