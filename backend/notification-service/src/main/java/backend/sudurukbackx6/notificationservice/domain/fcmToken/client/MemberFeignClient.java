package backend.sudurukbackx6.notificationservice.domain.fcmToken.client;

import backend.sudurukbackx6.notificationservice.domain.fcmToken.client.dto.response.MemberResDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;

@FeignClient(url = "http://k9d102.p.ssafy.io:8081", name = "store-service")
public interface MemberFeignClient {
    @GetMapping("/api/member/firebaseToken")
    MemberResDto getFirebaseToken(@RequestHeader("Authorization") String token);
}
