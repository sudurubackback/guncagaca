package backend.sudurukbackx6.orderservice.client;

import backend.sudurukbackx6.orderservice.domain.order.client.dto.response.MemberInfoResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@FeignClient(url = "http://k9d102.p.ssafy.io:8081", name="member-service")
public interface MemberServiceClient {

    @GetMapping("/api/member/id")
    Long getId(@RequestHeader("Email") String email);

    @GetMapping("/api/member/firebaseToken/{memberId}")
    String getFirebaseTokenByMemberId(@PathVariable Long memberId);

    @GetMapping("/api/member/memberInfo")
    MemberInfoResponse getMemberInfo(@RequestHeader("Email") String email);

    @PostMapping("/api/member/memberInfo/bulk")
    List<MemberInfoResponse> getMemberInfo(@RequestHeader("Email") String email, @RequestBody List<Long> memberIds);

}
