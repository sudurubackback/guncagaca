package backend.sudurukbackx6.notificationservice.domain.fcmToken.service;

import backend.sudurukbackx6.notificationservice.domain.fcmToken.repository.AlertHistoryRepository;
import backend.sudurukbackx6.notificationservice.domain.fcmToken.service.dto.FCMNotificationRequestDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;


import lombok.RequiredArgsConstructor;


@RequiredArgsConstructor
@Service
@Slf4j
public class FCMNotificationService {

//	private final FirebaseMessaging firebaseMessaging;
//	private final AlertHistoryRepository alertHistoryRepository;

	public String sendNotification(FCMNotificationRequestDto requestDto) {

//		Member member = memberRepository.findById(requestDto.getMemberId()).orElseThrow(()
//			-> new BusinessException(ErrorCode.NOT_EXISTS_USER_ID)
//		);
//
//		if (member.getFirebaseToken() != null) {
//			Notification notification = Notification.builder()
//				.setTitle(requestDto.getTitle())
//				.setBody(requestDto.getBody())
//				.setImage(requestDto.getImageUrl())
//				.build();
//
//			Message message = Message.builder()
//				.setToken(member.getFirebaseToken())
//				.setNotification(notification)
//				.putData("productCode", requestDto.getProductCode())
//				.build();
//
//			try {
//				log.info("title {}", requestDto.getTitle());
//				firebaseMessaging.send(message);
//
//				// 알림 내역 저장
//				AlertHistory alertHistory = AlertHistory.builder()
//					.title(requestDto.getTitle())
//					.body(requestDto.getBody())
//					.member(member)
//					.imageUrl(requestDto.getImageUrl())
//					.productCode(requestDto.getProductCode())
//					.build();
//				alertHistoryRepository.save(alertHistory);
//
//				return "send 성공";
//
//			} catch (FirebaseMessagingException e) {
//				throw new RuntimeException(e);
//			}
//		}
//		else {
//			return "FCMToken 없습니다";
//		}
		return null;
	}
}
