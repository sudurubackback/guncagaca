package backend.sudurukbackx6.notificationservice.domain.fcmToken.client;

import backend.sudurukbackx6.notificationservice.domain.fcmToken.client.dto.response.MemberInfoResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@FeignClient(url = "http://k9d102.p.ssafy.io:8081", name = "member-service")
public interface MemberFeignClient {
    @GetMapping("/api/member/firebaseToken/{memberId}")
    String getFirebaseTokenByMemberId(@PathVariable Long memberId);

    @GetMapping("/api/member/memberInfo")
    MemberInfoResponse getMemberInfo(@RequestHeader("Email") String email);

    @PostMapping("/api/member/memberInfo/bulk")
    List<MemberInfoResponse> getMemberInfo(@RequestHeader("Email") String email, @RequestBody List<Long> memberIds);

}
