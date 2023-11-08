package backend.sudurukbackx6.orderservice.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@FeignClient(url = "http://k9d102.p.ssafy.io:8081", name="member-service")
public interface MemberServiceClient {

    @GetMapping("/api/member/id")
    Long getId(@RequestParam String email);
}
