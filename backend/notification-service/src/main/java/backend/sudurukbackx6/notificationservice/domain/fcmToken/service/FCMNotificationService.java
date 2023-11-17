package backend.sudurukbackx6.notificationservice.domain.fcmToken.service;

import backend.sudurukbackx6.notificationservice.common.error.code.ErrorCode;
import backend.sudurukbackx6.notificationservice.common.error.exception.BadRequestException;
import backend.sudurukbackx6.notificationservice.domain.fcmToken.client.MemberFeignClient;
import backend.sudurukbackx6.notificationservice.domain.fcmToken.client.dto.response.MemberResDto;
import backend.sudurukbackx6.notificationservice.domain.fcmToken.entity.AlertHistory;
import backend.sudurukbackx6.notificationservice.domain.fcmToken.entity.Status;
import backend.sudurukbackx6.notificationservice.domain.fcmToken.repository.AlertHistoryRepository;
import backend.sudurukbackx6.notificationservice.domain.fcmToken.service.dto.FCMNotificationRequestDto;
import backend.sudurukbackx6.notificationservice.domain.fcmToken.service.dto.NotificationDto;
import backend.sudurukbackx6.notificationservice.domain.fcmToken.service.dto.NotificationEvent;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Service;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;


import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;


@RequiredArgsConstructor
@Service
@Slf4j
@Transactional
public class FCMNotificationService {

	private final FirebaseMessaging firebaseMessaging;
	private final AlertHistoryService alertHistoryService;
	private final MemberFeignClient memberFeignClient;

	@KafkaListener(topics = "orderNotification", groupId = "notification")
	public void subscribeEvent(@Payload String eventString) {
		// json으로 역직렬화
		ObjectMapper objectMapper = new ObjectMapper();
		try {
			NotificationEvent notificationEvent = objectMapper.readValue(eventString, NotificationEvent.class);
			sendFCM(notificationEvent);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		} catch (FirebaseMessagingException e) {
            throw new RuntimeException(e);
        }
    }

	public void sendFCM(NotificationEvent notificationEvent) throws FirebaseMessagingException {

		String firebaseToken = memberFeignClient.getFirebaseTokenByMemberId(notificationEvent.getMemberId());
		log.info(firebaseToken);

		if(firebaseToken==null){
			throw new BadRequestException(ErrorCode.EMPTY_FIREBASE_TOKEN);
		}

		//이제 fcm코드로 바꾼다.
		NotificationDto notificationDto = makeNotification(notificationEvent);

		Notification notification = Notification.builder()
				.setTitle(notificationDto.getTitle())
				.setBody(notificationDto.getBody())
				.setImage("icon.png")
				.build();

		Message message = Message.builder()
				.setToken(firebaseToken)
				.setNotification(notification)
				.build();

		firebaseMessaging.send(message);

		alertHistoryService.saveAlertHistory(notificationEvent, notificationDto);
	}

	public NotificationDto makeNotification(NotificationEvent notificationEvent) {
		String title = "알림";
		String body = "";
		String cafeNAme = notificationEvent.getStoreName();
		switch (notificationEvent.getStatus()) {
			case REQUEST:
				title = "주문이 접수되었습니다.";
				body = cafeNAme + "에서 주문하신 메뉴를 진행중 입니다.\n주문메뉴 : " + notificationEvent.getOrderMenu();
				break;
			case COMPLETE:
				title = "조리가 완료되었습니다.";
				body = cafeNAme + "에서 조리를 완료하였습니다. 맛있게 드세요.\n주문메뉴 : " + notificationEvent.getOrderMenu();
				break;
			case CANCELED:
				title = "주문이 취소되었습니다.";
				body = cafeNAme + "에서 주문을 취소하였습니다. 사유 :" + notificationEvent.getReason();
				break;

		}
		return new NotificationDto(title, body);
	}

}
