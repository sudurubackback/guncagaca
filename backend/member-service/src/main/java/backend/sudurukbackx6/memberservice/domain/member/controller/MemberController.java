package backend.sudurukbackx6.memberservice.domain.member.controller;

import backend.sudurukbackx6.memberservice.domain.member.dto.*;
import backend.sudurukbackx6.memberservice.domain.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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
    public ResponseEntity<MypageResponse> getMypage(@RequestHeader("Email") String email) {
        return ResponseEntity.ok(memberService.getMypage(email));
    }

    @PutMapping("/mypage/change-nickname")
    public ResponseEntity<MypageResponse> changeNickname(@RequestHeader("Email") String email, @RequestParam String nickname) {
        return ResponseEntity.ok(memberService.changeNickname(email, nickname));
    }

    @GetMapping("/mypage/point")
    public ResponseEntity<List<MyPointsResponse>> getMyPoints(@RequestHeader("Email") String email) {
        return ResponseEntity.ok(memberService.myPoint(email));
    }

    @GetMapping("/mypage/point/{cafe_id}")
    public ResponseEntity<PointStoreResponse> getPointStore(@RequestHeader("Email") String email,@PathVariable Long cafe_id){
        return ResponseEntity.ok(memberService.pointStore(email, cafe_id));
    }
}
