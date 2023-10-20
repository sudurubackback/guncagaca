package backend.sudurukbackx6.memberservice.domain.member.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/member")
public class MemberController {

    /* TODO
    카카오 소셜 로그인 구현
     */
    @GetMapping("/sign")
    public Object sign() {
        return "sign";
    }
}
