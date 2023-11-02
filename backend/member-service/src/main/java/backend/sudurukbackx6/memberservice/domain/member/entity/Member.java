package backend.sudurukbackx6.memberservice.domain.member.entity;

import backend.sudurukbackx6.memberservice.domain.points.entity.Point;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class Member {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "member_id")
    private Long id;

    private String nickname;

    private String email;

    @OneToMany(mappedBy = "member")
    private List<Point> points;

    @Builder
    public Member(Long id, String nickname, String email) {
        this.id = id;
        this.nickname = nickname;
        this.email = email;
    }


    /**
    * 비즈니스 로직
     */
    // 닉네임 수정
    public void changeNickname(String nickname) {
        this.nickname = nickname;
    }
}
