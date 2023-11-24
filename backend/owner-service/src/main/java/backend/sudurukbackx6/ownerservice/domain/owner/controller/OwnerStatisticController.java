package backend.sudurukbackx6.ownerservice.domain.owner.controller;

import backend.sudurukbackx6.ownerservice.domain.owner.service.OwnerStatisticsService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/owner")
public class OwnerStatisticController {

    private final OwnerStatisticsService ownerStatisticsService;

   /* @GetMapping("/{storeId}")
    public List<GetTodaySellingResponse> getTodaySelling(@PathVariable("storeId") Long storeId){
        return ownerStatisticsService.getTodaySelling(storeId);
    }*/
}
