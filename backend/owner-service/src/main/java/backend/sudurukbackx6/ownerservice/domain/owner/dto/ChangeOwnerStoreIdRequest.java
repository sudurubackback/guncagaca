package backend.sudurukbackx6.ownerservice.domain.owner.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ChangeOwnerStoreIdRequest {

    private String email;
    private Long storeId;
}
