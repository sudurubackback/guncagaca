package backend.sudurukbackx6.orderservice.domain.order.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;

import javax.persistence.Column;

@Getter
@NoArgsConstructor
public class DetailOptionRequestDto {

    private String detailOptionId;

    private String detailOptionName;

    private int additionalPrice;
}
