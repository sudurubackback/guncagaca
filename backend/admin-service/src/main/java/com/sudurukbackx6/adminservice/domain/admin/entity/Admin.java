package com.sudurukbackx6.adminservice.domain.admin.entity;

import com.sudurukbackx6.adminservice.common.entity.TimeEntity;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Getter
@Entity
@Table(name = "admin")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Admin extends TimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "admin_id")
    private Long id;

    @Column(nullable = false, columnDefinition = "VARCHAR(500)")
    private String name;

    @Column(nullable = false, columnDefinition = "VARCHAR(500)")
    private String email;

    @Column(nullable = false, columnDefinition = "VARCHAR(500)")
    private String password;
}
