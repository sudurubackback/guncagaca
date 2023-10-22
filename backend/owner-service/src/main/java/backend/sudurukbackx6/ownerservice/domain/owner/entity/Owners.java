package backend.sudurukbackx6.ownerservice.domain.owner.entity;

import backend.sudurukbackx6.ownerservice.common.entity.TimeEntity;
import backend.sudurukbackx6.ownerservice.domain.business.entity.Business;
import lombok.*;

import javax.persistence.*;

@Getter
@Entity
@Table(name = "onwers")
@AllArgsConstructor
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Owners extends TimeEntity {

    @Id //Primary Key
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "owner_id")
    private Long onwerId;

    @OneToOne(mappedBy = "onwers", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    private Business business;

    private String password;
    private String email;
    private String tel;
}
