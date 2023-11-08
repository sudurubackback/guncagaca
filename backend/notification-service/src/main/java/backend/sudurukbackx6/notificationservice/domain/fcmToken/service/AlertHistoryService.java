package backend.sudurukbackx6.notificationservice.domain.fcmToken.service;

import backend.sudurukbackx6.notificationservice.domain.fcmToken.client.MemberFeignClient;
import backend.sudurukbackx6.notificationservice.domain.fcmToken.client.dto.response.MemberInfoResponse;
import backend.sudurukbackx6.notificationservice.domain.fcmToken.service.dto.AlertHistoryDto;
import backend.sudurukbackx6.notificationservice.domain.fcmToken.entity.AlertHistory;
import backend.sudurukbackx6.notificationservice.domain.fcmToken.repository.AlertHistoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AlertHistoryService {
	private final AlertHistoryRepository alertHistoryRepository;
	private final MemberFeignClient memberFeignClient;

	// 알림 목록 조회
	public List<AlertHistoryDto> getAlertHistory(String token) {
		MemberInfoResponse memberInfo = memberFeignClient.getMemberInfo(token);
		Long myId = memberInfo.getId();
		List<AlertHistory> alertHistories = alertHistoryRepository.findAllByMemberId(myId);

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
//
//	// 알림 삭제
//	public void deleteAlertHistory(Long alertId, Long memberId) {
//		// 알림 기록 가져오기
//		AlertHistory alertHistory = alertHistoryRepository.findById(alertId)
//			.orElseThrow(() -> new BusinessException(ErrorCode.NOT_EXISTS_ALERT_HISTORY));
//		// 본인 아닌경우
//		if (!alertHistory.getMember().getId().equals(memberId)) {
//			throw new BusinessException(ErrorCode.UNAUTHORIZED_MEMBER);
//		}
//		// 삭제
//		alertHistoryRepository.delete(alertHistory);
//	}
//
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
