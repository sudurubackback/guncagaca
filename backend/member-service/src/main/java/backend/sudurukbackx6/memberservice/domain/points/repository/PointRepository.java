package backend.sudurukbackx6.memberservice.domain.points.repository;

import backend.sudurukbackx6.memberservice.domain.points.entity.Point;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PointRepository extends JpaRepository<Point, Long> {
}
