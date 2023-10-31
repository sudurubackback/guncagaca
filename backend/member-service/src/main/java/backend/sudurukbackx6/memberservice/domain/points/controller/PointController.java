package backend.sudurukbackx6.memberservice.domain.points.controller;

import backend.sudurukbackx6.memberservice.domain.points.service.PointServiceImpl;
import backend.sudurukbackx6.memberservice.domain.points.service.dto.PointSaveRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/point")
@RequiredArgsConstructor
public class PointController {

    private final PointServiceImpl pointService;

    @PostMapping("/{member_id}/point/plus/{cafe_id}")
    public void plus(@PathVariable Long member_id, @PathVariable Long cafe_id, @RequestBody PointSaveRequest request){
        pointService.pointPlus(member_id, cafe_id, request);
    }

}
