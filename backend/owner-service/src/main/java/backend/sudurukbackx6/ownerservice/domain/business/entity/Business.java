package backend.sudurukbackx6.ownerservice.domain.business.entity;

import backend.sudurukbackx6.ownerservice.common.entity.TimeEntity;
import backend.sudurukbackx6.ownerservice.domain.business.dto.request.VendorVailidateReqDto;
import backend.sudurukbackx6.ownerservice.domain.owner.entity.Owners;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDate;

@Getter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Business extends TimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "business_Id")
    private Long businessId;

    @OneToOne
    @JoinColumn(name = "owner_id")
    private Owners owner;

    @Column(name = "business_number")
    private String businessNum;

    @Column(name = "account_number")
    private String accountNum;

    @Column(name = "open_date")
    private LocalDate openDate;

    @Column(name = "owner_name")
    private String name;

    //builer생성
    public Business(Owners owner, VendorVailidateReqDto dto) {
        this.owner = owner;
        this.businessNum = dto.getBusiness_number();
        this.accountNum = dto.getAccount_number();
        this.openDate = LocalDate.parse(dto.getOpen_date());
        this.name = dto.getOwner_name();
    }
}
