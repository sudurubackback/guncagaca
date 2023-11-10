package backend.sudurukbackx6.ownerservice.domain.owner.entity;

import backend.sudurukbackx6.ownerservice.common.entity.TimeEntity;
import backend.sudurukbackx6.ownerservice.domain.business.entity.Business;
import backend.sudurukbackx6.ownerservice.domain.owner.dto.request.SignUpReqDto;
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

    /*    @OneToOne(mappedBy = "owner", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
        private */
    @OneToOne
    @JoinColumn(name = "business_Id")
    private Business business;

    private String password;

    private String email;

    private String tel;

    private Long storeId;

    private boolean validation = false;

    private String ip;

    private String ddns;

    private String port;

    public void changeValidation() {
        validation = !validation;
    }

    @Builder
    public Owners(Long ownerId, Business business, String password, String email, String tel, Long storeId, String ip, String ddns, String port) {
        this.ownerId = ownerId;
        this.business = business;
        this.password = password;
        this.email = email;
        this.tel = tel;
        this.storeId = storeId;
        this.ip = ip;
        this.ddns = ddns;
        this.port = port;
    }

    @Builder
    public Owners(String email, String password, String tel, Business business) {
        this.email = email;
        this.password = password;
        this.tel = tel;
        this.business = business;
    }

    public void changePassword(String newPassword) {
        this.password = newPassword;
    }

    public void setStoreId(Long id) {
        this.storeId = id;
    }
}
