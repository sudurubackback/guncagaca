package backend.sudurukbackx6.ownerservice.domain.menu.service.dto;

import java.util.List;

import backend.sudurukbackx6.ownerservice.domain.menu.entity.OptionsEntity;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class MenuRegisterRequest {
	private String name;
	private int price;
	private List<OptionsEntity> optionsList;

}
