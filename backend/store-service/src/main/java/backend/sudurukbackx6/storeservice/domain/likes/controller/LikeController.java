package backend.sudurukbackx6.storeservice.domain.likes.controller;

import backend.sudurukbackx6.storeservice.domain.likes.service.LikeServiceImpl;
import backend.sudurukbackx6.storeservice.domain.reviews.client.MemberServiceClient;
import backend.sudurukbackx6.storeservice.domain.reviews.client.dto.MemberInfoResponse;
import backend.sudurukbackx6.storeservice.domain.store.entity.Store;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/like")
@RequiredArgsConstructor
public class LikeController {

    private final LikeServiceImpl likeService;
    private final MemberServiceClient memberServiceClient;

    // 멤버가 찜한 목록 조회
    @GetMapping("/like-store")
    public ResponseEntity<List<Store>> LikedStoresByMemberId(@RequestHeader("Authorization") String token, @PathVariable Long memberId){
        MemberInfoResponse memberInfo = memberServiceClient.getMemberInfo(token);
        return ResponseEntity.ok(likeService.getLikedStoresByMemberId(memberInfo.getId()));

    }

}
