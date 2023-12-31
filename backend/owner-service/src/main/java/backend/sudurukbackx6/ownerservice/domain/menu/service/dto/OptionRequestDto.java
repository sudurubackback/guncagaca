package backend.sudurukbackx6.ownerservice.domain.menu.service.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
public class OptionRequestDto {
    private String optionId;

    private String optionName;

    private List<DetailOptionRequestDto> detailOptions;
}
