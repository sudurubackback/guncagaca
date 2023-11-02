package backend.sudurukbackx6.memberservice.domain.points.entity;

import backend.sudurukbackx6.memberservice.domain.member.entity.Member;
import lombok.*;

import javax.persistence.*;

@Data
@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Point {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private int point;

    private Long storeId;

    @ManyToOne(fetch = FetchType.LAZY)
    private Member member;

    @Builder
    public Point(Long id,int point,Long storeId,Member member ) {
        this.id = id;
        this.point = point;
        this.storeId = storeId;
        this.member = member;

    }
}
