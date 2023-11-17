package backend.sudurukbackx6.storeservice.domain.likes.controller;

import backend.sudurukbackx6.storeservice.domain.likes.dto.LikeResponse;
import backend.sudurukbackx6.storeservice.domain.likes.service.LikeServiceImpl;
import backend.sudurukbackx6.storeservice.domain.reviews.client.MemberServiceClient;
import backend.sudurukbackx6.storeservice.domain.reviews.client.dto.MemberInfoResponse;
import backend.sudurukbackx6.storeservice.domain.store.entity.Store;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/store")
@RequiredArgsConstructor
public class LikeController {

    private final LikeServiceImpl likeService;
    private final MemberServiceClient memberServiceClient;

    // 멤버가 찜한 목록 조회
    @GetMapping("/mypage/like-store")
    @Operation(summary = "찜 가게 조회", description = "token 필요\n현재 멤버가 찜한 가게 리스트 조회", tags = { "Store Controller" })
    public ResponseEntity<List<LikeResponse>> LikedStoresByMemberId(@RequestHeader("Email") String email){
        MemberInfoResponse memberInfo = memberServiceClient.getMemberInfo(email);
        return ResponseEntity.ok(likeService.getLikedStoresByMemberId(memberInfo.getId()));

    }
}
