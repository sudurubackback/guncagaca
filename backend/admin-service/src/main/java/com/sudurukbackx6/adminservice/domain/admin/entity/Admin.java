package com.sudurukbackx6.adminservice.domain.admin.entity;

import com.sudurukbackx6.adminservice.common.entity.TimeEntity;
import com.sudurukbackx6.adminservice.domain.owner.entity.Owners;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Getter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Admin extends TimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "admin_Id")
    private Long businessId;

    @OneToOne(mappedBy = "admin", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    private Owners owners;

    private boolean approval;

    // approval 필드를 토글하는 메서드
    public void toggleApproval() {
        this.approval = !this.approval;
    }


}
