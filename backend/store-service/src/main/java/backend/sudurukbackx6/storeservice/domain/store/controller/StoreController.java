package backend.sudurukbackx6.storeservice.domain.store.controller;

import backend.sudurukbackx6.storeservice.domain.store.service.StoreServiceImpl;
import backend.sudurukbackx6.storeservice.domain.store.service.dto.*;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/store")
@RequiredArgsConstructor
public class StoreController {

    private final StoreServiceImpl storeService;


    @PostMapping("/save")
    public void cafeSave(@RequestBody StoreRequest request){
        storeService.cafeSave(request);
    }


    // 위도 경도 차이를 통해 0.0135가 1.5km 정도의 차이
    @GetMapping("/cafe-list")
    public List<NeerStoreResponse> cafeList( @RequestBody LocateRequest request){
        return storeService.cafeList(request);
    }

    @GetMapping("/cafe/{cafe_id}")
    public StoreResponse cafeDetail(@PathVariable Long cafe_id){
        return storeService.cafeDetail(cafe_id);
    }

    @GetMapping("/cafe/{cafe_id}/menu")
    public List<StoreMenuResponse> cafeMenu (@RequestHeader("Authorization") String token, @PathVariable Long cafe_id){
        return null;
    }

    @GetMapping("/cafe/{cafe_id}/menu/{index}")
    public StoreMenuResponse cafeMenuDetail(@RequestHeader("Authorization") String token, @PathVariable Long cafe_id, @PathVariable Long index){
        return null;
    }


    // @GetMapping("/cafe/{cafe_id}/detail")
    // public ShowStoreResponse cafeDescription(@RequestBody Long memberId, @PathVariable Long cafe_id){
    //     return storeService.cafeDescription(memberId, cafe_id);
    // }

    @GetMapping("/cafe/{cafe_id}/review")
    public List<StoreReviewResponse> cafeReview(@RequestHeader("Authorization") String token, @PathVariable Long cafe_id){
        return storeService.cafeReview(token, cafe_id);
    }
}