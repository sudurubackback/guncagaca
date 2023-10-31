package backend.sudurukbackx6.memberservice.domain.points.service;


import backend.sudurukbackx6.memberservice.domain.points.service.dto.PointSaveRequest;

public interface PointService {
    void pointPlus(Long memberId, Long cafeId, PointSaveRequest request);
    void pointMinus(Long memberId, Long cafeId, PointSaveRequest request);

}
