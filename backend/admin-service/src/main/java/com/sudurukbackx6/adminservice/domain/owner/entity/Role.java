package com.sudurukbackx6.adminservice.domain.owner.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public enum Role {
    USER("유저"),
    ADMIN("관리자"),;

    private String role;

    Role(String role) {
        this.role = role;
    }



}
