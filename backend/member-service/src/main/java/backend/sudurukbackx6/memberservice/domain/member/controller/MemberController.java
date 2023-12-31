package backend.sudurukbackx6.memberservice.domain.member.controller;

import backend.sudurukbackx6.memberservice.domain.member.dto.MemberInfoResponse;
import backend.sudurukbackx6.memberservice.domain.member.dto.SignRequestDto;
import backend.sudurukbackx6.memberservice.domain.member.dto.SignResponseDto;
import backend.sudurukbackx6.memberservice.domain.member.dto.*;
import backend.sudurukbackx6.memberservice.domain.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @PostMapping("/signout")
    public ResponseEntity<String> getSignout(@RequestHeader("Email") String email) {
        memberService.getSignout(email);
        return ResponseEntity.ok("로그아웃이 완료되었습니다.");
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

    /* OpenFeign을 통해 받아올 떄 안에 memberId, email, nickname을 반환*/
    @GetMapping("/memberInfo")
    public ResponseEntity<MemberInfoResponse> getMemberInfo(@RequestHeader("Email") String email) {
        return ResponseEntity.ok(memberService.getMemberInfo(email));
    }

    // memberId 리스트로 받아서 리스트로 반환
    @PostMapping("/memberInfo/bulk")
    public List<MemberInfoResponse> getMemberInfoBulk(@RequestHeader("Email") String email, @RequestBody List<Long> memberIds) {
        return memberService.getMemberInfoBulk(memberIds);
    }

    @GetMapping("/mypage/point")
    public ResponseEntity<List<MyPointsResponse>> getMyPoints(@RequestHeader("Email") String email) {
        return ResponseEntity.ok(memberService.myPoint(email));
    }

    @GetMapping("/mypage/point/{cafe_id}")
    public ResponseEntity<PointStoreResponse> getPointStore(@RequestHeader("Email") String email, @PathVariable Long cafe_id){
        return ResponseEntity.ok(memberService.pointStore(email, cafe_id));
    }

    @GetMapping("/id")
    public ResponseEntity<Long> getId(@RequestHeader("Email") String email) {
        return ResponseEntity.ok(memberService.getId(email));
    }

    @GetMapping("/firebaseToken")
    public ResponseEntity<Map<String,String>> getFirebaseToken(@RequestHeader("Email") String email) {
        Map<String, String> map = new HashMap<>();
        map.put("firebase_token", memberService.getFirebaseToken(email));
        return ResponseEntity.ok(map);
    }
    
    @GetMapping("/firebaseToken/{memberId}")
    public ResponseEntity<String> getFirebaseTokenByMemberId(@PathVariable Long memberId) {
        return ResponseEntity.ok(memberService.getFirebaseTokenByMemberId(memberId));
    }
}

