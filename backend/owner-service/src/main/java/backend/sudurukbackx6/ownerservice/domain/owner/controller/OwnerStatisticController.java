package backend.sudurukbackx6.ownerservice.domain.owner.controller;


import backend.sudurukbackx6.ownerservice.domain.owner.dto.GetTodaySellingResponse;
import backend.sudurukbackx6.ownerservice.domain.owner.service.OwnerStatisticsService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/ceo")
public class OwnerStatisticController {

    private final OwnerStatisticsService ownerStatisticsService;

    @GetMapping("/{storeId}")
    public List<GetTodaySellingResponse> getTodaySelling(@PathVariable("storeId") Long storeId){
        return ownerStatisticsService.getTodaySelling(storeId);
    }
}
