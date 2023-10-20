package backend.sudurukbackx6.memberservice.domain.member.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
@Getter
@NoArgsConstructor
public class Member {

    @Id
    @Column(name = "member_id")
    private Long id;

    private String nickname;

    private String email;

    private String tel;
}
