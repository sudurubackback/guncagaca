package com.sudurukbackx6.adminservice.domain.owner.entity;

import com.sudurukbackx6.adminservice.common.entity.TimeEntity;
import com.sudurukbackx6.adminservice.domain.admin.entity.Admin;
import com.sudurukbackx6.adminservice.domain.owner.dto.request.NetworkReqDto;
import com.sudurukbackx6.adminservice.domain.store.entity.Store;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

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
    @OneToOne
    @JoinColumn(name = "admin_Id")
    private Admin admin;
    private String password;
    private String email;
    private String tel;

    @OneToOne(mappedBy = "owner", cascade = CascadeType.ALL)
    private Store store;

    private boolean validation = false;

    // ip, 포트번호, ddns
    private String ip;

    private String port;

    private String ddns;

    private Role role;

    public void changeValidation() {
        validation = !validation;
    }

    @Builder
    public Owners(Long ownerId, Business business,Admin admin, String password, String email, String tel, Store store) {
        this.ownerId = ownerId;
        this.business = business;
        this.admin = admin;
        this.password = password;
        this.email = email;
        this.tel = tel;
        this.store = store;
    }

    @Builder
    public Owners(String email, String password, String tel, Business business, Role role) {
        this.email = email;
        this.password = password;
        this.tel = tel;
        this.business = business;
        this.role = role;
    }

    public void changePassword(String newPassword) {
        this.password = newPassword;
    }

    public void changeNetwork(String ip, String ddns, String port) {
        this.ip = ip;
        this.ddns = ddns;
        this.port = port;
    }


}
