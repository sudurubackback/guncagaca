package backend.sudurukbackx6.notificationservice.domain.fcmToken.controller;

import backend.sudurukbackx6.notificationservice.domain.fcmToken.service.dto.FCMNotificationRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/v1/fcm")
public class FCMController {

	private final FCMNotificationService fcmNotificationService;

	@PostMapping("/send")
	public String sendMessaging(@RequestBody FCMNotificationRequestDto requestDto){
		return fcmNotificationService.sendNotification(requestDto);
	}
}
