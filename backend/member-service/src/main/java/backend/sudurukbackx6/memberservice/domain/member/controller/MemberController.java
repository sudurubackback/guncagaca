package backend.sudurukbackx6.memberservice.domain.member.controller;

import backend.sudurukbackx6.memberservice.domain.member.dto.MypageResponseDto;
import backend.sudurukbackx6.memberservice.domain.member.dto.MemberInfoResponse;
import backend.sudurukbackx6.memberservice.domain.member.dto.SignRequestDto;
import backend.sudurukbackx6.memberservice.domain.member.dto.SignResponseDto;
import backend.sudurukbackx6.memberservice.domain.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/member")
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;

    @GetMapping("/health")
    public ResponseEntity<String> getHealth() {
        return ResponseEntity.ok("Member is okay");
    }

    @PostMapping("/sign")
    public ResponseEntity<SignResponseDto> getSign(@RequestBody SignRequestDto signRequestDto) {
        return ResponseEntity.ok(memberService.getSign(signRequestDto));
    }

    @PostMapping("/refresh")
    public ResponseEntity<SignResponseDto> refreshAccessToken(@RequestHeader("Email") String email) {
        return ResponseEntity.ok(memberService.refreshAccessToken(email));
    }

    @GetMapping("/mypage")
    public ResponseEntity<MypageResponseDto> getMypage(@RequestHeader("Email") String email) {
        return ResponseEntity.ok(memberService.getMypage(email));
    }

    @PutMapping("/mypage/change-nickname")
    public ResponseEntity<MypageResponseDto> changeNickname(@RequestHeader("Email") String email, @RequestParam String nickname) {
        return ResponseEntity.ok(memberService.changeNickname(email, nickname));
    }

    /* OpenFeign을 통해 받아올 떄 안에 memberId, email, nickname을 반환*/
    @GetMapping("/memberInfo")
    public ResponseEntity<MemberInfoResponse> getMemberInfo(@RequestHeader("Authorization") String token){
        return ResponseEntity.ok(memberService.getMemberInfo(token));
    }
}
