package backend.sudurukbackx6.memberservice.domain.points.service;


import backend.sudurukbackx6.memberservice.domain.points.service.dto.PointSaveRequest;

public interface PointService {
    void pointPlus(String email, Long cafeId, PointSaveRequest request);
    void pointMinus(String email, Long cafeId, PointSaveRequest request);

}
