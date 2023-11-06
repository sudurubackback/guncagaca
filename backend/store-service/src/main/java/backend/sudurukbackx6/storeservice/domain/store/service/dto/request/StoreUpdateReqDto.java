package backend.sudurukbackx6.storeservice.domain.store.service.dto.request;

import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class StoreUpdateReqDto {
    private String tel;
    private String description;
    private String openTime;
    private String closeTime;
}
