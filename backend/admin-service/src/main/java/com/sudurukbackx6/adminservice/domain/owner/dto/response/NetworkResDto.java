package com.sudurukbackx6.adminservice.domain.owner.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
public class NetworkResDto {
    String ddns;
    String ip;
    String port;
}
