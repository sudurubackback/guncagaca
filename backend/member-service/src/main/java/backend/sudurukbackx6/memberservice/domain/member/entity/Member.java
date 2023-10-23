package backend.sudurukbackx6.memberservice.domain.member.entity;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor
public class Member {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "member_id")
    private Long id;

    private String nickname;

    private String email;

    private String tel;

    @Builder
    public Member(Long id, String nickname, String email, String tel) {
        this.id = id;
        this.nickname = nickname;
        this.email = email;
        this.tel = tel;
    }
}
