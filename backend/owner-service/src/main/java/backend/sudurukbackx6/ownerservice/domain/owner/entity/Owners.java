package backend.sudurukbackx6.ownerservice.domain.owner.entity;

import backend.sudurukbackx6.ownerservice.common.entity.TimeEntity;
import backend.sudurukbackx6.ownerservice.domain.business.entity.Business;
import lombok.*;

import javax.persistence.*;

@Getter
@Entity
@Table(name = "owners")
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
    private Long storeId;

    @Builder
    public Owners(String email, String password, String tel) {
        this.email = email;
        this.password = password;
        this.tel = tel;
    }

    @Builder
    public Owners(Long ownerId, Business business, String password, String email, String tel, Long storeId) {
        this.ownerId = ownerId;
        this.business = business;
        this.password = password;
        this.email = email;
        this.tel = tel;
        this.storeId = storeId;
    }

    public void changePassword(String newPassword) {
        this.password = newPassword;
    }

    public void setStoreId(Long id) {
        this.storeId = id;
    }
}
