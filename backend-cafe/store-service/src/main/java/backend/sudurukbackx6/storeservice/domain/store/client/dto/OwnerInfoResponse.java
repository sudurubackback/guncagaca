package backend.sudurukbackx6.storeservice.domain.store.client.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
public class OwnerInfoResponse {
    private String email;
    private String tel;
    private Long storeId;
}