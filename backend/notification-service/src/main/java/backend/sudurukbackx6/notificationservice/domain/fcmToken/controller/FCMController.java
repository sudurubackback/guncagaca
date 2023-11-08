package backend.sudurukbackx6.notificationservice.domain.fcmToken.controller;

import backend.sudurukbackx6.notificationservice.common.dto.BaseResponseBody;
import backend.sudurukbackx6.notificationservice.domain.fcmToken.service.FCMNotificationService;
import backend.sudurukbackx6.notificationservice.domain.fcmToken.service.dto.FCMNotificationRequestDto;
import com.google.firebase.messaging.FirebaseMessagingException;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/v1/fcm")
public class FCMController {

	private final FCMNotificationService fcmNotificationService;

	@PostMapping("/send")
	public String sendMessaging(@RequestBody FCMNotificationRequestDto requestDto){
		return fcmNotificationService.sendNotification(requestDto);
	}

	@PostMapping("/sendMember")
	public ResponseEntity<? extends BaseResponseBody> sendPushMember(@RequestHeader("Authorization") String header,  @RequestBody FCMNotificationRequestDto requestDto) throws FirebaseMessagingException {
		return ResponseEntity.status(HttpStatus.OK).body(new BaseResponseBody<>(200, "알림 전송 성공"));
	}
}
