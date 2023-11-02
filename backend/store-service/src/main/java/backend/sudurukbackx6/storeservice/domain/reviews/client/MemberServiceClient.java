package backend.sudurukbackx6.storeservice.domain.reviews.client;

import backend.sudurukbackx6.storeservice.domain.reviews.client.dto.MemberInfoResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;

import java.util.List;

@FeignClient(url = "k9d102.p.ssafy.io:8081", name="member-service")
public interface MemberServiceClient {

    @GetMapping("/api/member/memberInfo")
    MemberInfoResponse getMemberInfo(@RequestHeader("Authorization") String token);

    @GetMapping("/api/member/memberInfo/bulk")
    List<MemberInfoResponse> getMemberInfo(@RequestHeader("Authorization") String token, @RequestBody List<Long> memberIds);
}
