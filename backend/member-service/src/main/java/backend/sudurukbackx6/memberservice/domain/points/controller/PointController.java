package backend.sudurukbackx6.memberservice.domain.points.controller;

import backend.sudurukbackx6.memberservice.domain.points.service.PointServiceImpl;
import backend.sudurukbackx6.memberservice.domain.points.service.dto.PointSaveRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/api/point")
@RequiredArgsConstructor
public class PointController {

    private final PointServiceImpl pointService;

    @PostMapping("/plus/{cafe_id}")
    public void plus(@RequestHeader("Email") String email, @PathVariable Long cafe_id, @RequestBody PointSaveRequest request){
        pointService.pointPlus(email, cafe_id, request);
    }

    @PostMapping("/minus/{cafe_id}")
    public void minus(@RequestHeader("Email") String email, @PathVariable Long cafe_id, @RequestBody PointSaveRequest request){
        pointService.pointMinus(email, cafe_id, request);
    }

}
