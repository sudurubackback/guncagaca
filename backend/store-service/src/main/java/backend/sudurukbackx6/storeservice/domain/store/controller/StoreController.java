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


    //TODO 이거 API통신으로 memberId 받아와야함.
    @GetMapping("/cafe-list")
    public List<NeerStoreResponse> cafeList(@RequestBody Long memberId, @RequestBody LocateRequest request){
        return null;
    }

    @GetMapping("/cafe/{cafe_id}")
    public StoreResponse cafeDetail(@RequestBody Long memberId, @PathVariable Long cafe_id){
        return storeService.cafeDetail(memberId, cafe_id);
    }

    //TODO 이거 API통신으로 memberId 받아와야함.
    @GetMapping("/cafe/{cafe_id}/menu")
    public List<StoreMenuResponse> cafeMenu (@RequestBody Long memberId, @PathVariable Long cafe_id){
        return null;
    }

    //TODO 이거 API통신으로 memberId 받아와야함
    @GetMapping("/cafe/{cafe_id}/menu/{index}")
    public StoreMenuResponse cafeMenuDetail(@RequestBody Long memberId, @PathVariable Long cafe_id, @PathVariable Long index){
        return null;
    }

    //TODO 이거 API통신으로 memberId 받아와야함.
    @GetMapping("/cafe/{cafe_id}/detail")
    public ShowStoreResponse cafeDescription(@RequestBody Long memberId, @PathVariable Long cafe_id){
        return null;
    }

    @GetMapping("/cafe/{cafe_id}/review")
    public List<StoreReviewResponse> cafeReview(@RequestBody Long memberId, @PathVariable Long cafe_id){
        return storeService.cafeReview(memberId, cafe_id);
    }

}