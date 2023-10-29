package backend.sudurukbackx6.orderservice.domain.order.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
public class OptionRequestDto {
    private String optionId;

    private String optionName;

    private List<DetailOptionRequestDto> detailsOptions;
}
