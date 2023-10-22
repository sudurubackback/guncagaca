package backend.sudurukbackx6.ownerservice.domain.business.entity;

import backend.sudurukbackx6.ownerservice.common.entity.TimeEntity;
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
    private int businessNum;

    @Column(name = "account_number")
    private String accountNum;

    @Column(name = "open_date")
    private LocalDate openDate;

    @Column(name = "owner_name")
    private String name;
}
