package backend.sudurukbackx6.ownerservice.domain.menu.service.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class DetailOptionRequestDto {

    private String detailOptionId;

    private String detailOptionName;

    private int additionalPrice;
}
