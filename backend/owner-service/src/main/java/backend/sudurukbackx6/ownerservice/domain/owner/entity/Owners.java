package backend.sudurukbackx6.ownerservice.domain.owner.entity;

import backend.sudurukbackx6.ownerservice.common.entity.TimeEntity;
import backend.sudurukbackx6.ownerservice.domain.business.entity.Business;
import lombok.*;

import javax.persistence.*;

@Getter
@Entity
@Table(name = "owners")
@AllArgsConstructor
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Owners extends TimeEntity {

    @Id //Primary Key
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "owner_id")
    private Long ownerId;

    @OneToOne(mappedBy = "owner", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    private Business business;

    private String password;
    private String email;
    private String tel;

    private boolean validation = false;

    public Owners(String email, String password, String tel) {
        this.email = email;
        this.password = password;
        this.tel = tel;
    }

    public void changeValidation(){
        validation = !validation;
    }

    public void changePassword(String newPassword) {
        this.password = newPassword;
    }
}
