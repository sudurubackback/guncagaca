package backend.sudurukbackx6.storeservice.domain.reviews.client;

import backend.sudurukbackx6.storeservice.domain.reviews.client.dto.MemberInfoResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;

@FeignClient(name="member-service")
public interface MemberServiceClient {

    @GetMapping("/api/member/memberInfo")
    MemberInfoResponse getMemberInfo(@RequestHeader("Authorization") String token);

}
