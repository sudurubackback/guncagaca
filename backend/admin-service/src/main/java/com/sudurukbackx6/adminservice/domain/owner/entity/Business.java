package com.sudurukbackx6.adminservice.domain.owner.entity;

import com.sudurukbackx6.adminservice.common.entity.TimeEntity;
import com.sudurukbackx6.adminservice.domain.owner.dto.request.BusinessValidReqDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

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

    @OneToOne(mappedBy = "business", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    private Owners owners;

    @Column(name = "business_number")
    private String businessNum;

    @Column(name = "account_number")
    private String accountNum;

    @Column(name = "open_date")
    private LocalDate openDate;

    @Column(name = "owner_name")
    private String name;

    @Column(nullable = false, columnDefinition = "VARCHAR(500)", name = "business_name")
    private String businessName;    //가게 이름

    @Column(nullable = false, columnDefinition = "VARCHAR(500)")
    private String address; //가게 주소

    @Column(nullable = false, columnDefinition = "VARCHAR(500)")
    private String img; //사업자등록증 사진 s3 업로드

    @Column(nullable = false, columnDefinition = "boolean default false")
    private boolean approval = false; //가게 승인 여부

    @Column(nullable = false, columnDefinition = "VARCHAR(500)")
    private String tel; //사업자등록증 사진 s3 업로드

    //builer생성
    public Business(BusinessValidReqDto dto, String uploadURL) {
        this.businessNum = dto.getBusiness_number();
        this.accountNum = dto.getAccount_number();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
        this.openDate = LocalDate.parse(dto.getOpen_date(), formatter);
        this.name = dto.getOwner_name();
        this.businessName = dto.getBusiness_name();
        this.address = dto.getAddress();
        this.img = uploadURL;
        this.tel = dto.getTel();
    }

    public void toggleApproval() {
        this.approval = !this.approval;
    }

}
