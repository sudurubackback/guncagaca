package com.sudurukbackx6.adminservice.domain.store.entity;

import com.sudurukbackx6.adminservice.domain.owner.entity.Owners;
import lombok.*;

import javax.persistence.*;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Store {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "store_id")
    private Long id;

    @Column(nullable = false, columnDefinition = "VARCHAR(500)")
    private String name;

    private Double latitude;

    private Double longitude;

    @Column(nullable = false,columnDefinition = "VARCHAR(500)")
    private String address;

    @Column(nullable = false)
    private String tel;

    @Column(columnDefinition = "VARCHAR(500)")
    private String img;

    @Column(nullable = false)
    private String description;

    @Column(nullable = false)
    private Double starPoint;

    @Column(nullable = false)
    private boolean isOpen;

    private String openTime;

    private String closeTime;

    @OneToOne(mappedBy = "store", cascade = CascadeType.ALL)
    private Owners owner;

    @Builder
    public Store(Long id, String name, Double latitude, Double longitude, String address, String tel, String img,
                 String openTime, String closeTime, String description, Owners owner) {
        this.id = id;
        this.name = name;
        this.latitude = latitude;
        this.longitude = longitude;
        this.address = address;
        this.tel = tel;
        this.img = img;
        this.isOpen = false;
        this.openTime = openTime;
        this.closeTime = closeTime;
        this.starPoint = 0.0;
        this.description = description;
        this.owner = owner;

    }

}
