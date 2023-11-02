package backend.sudurukbackx6.ownerservice.domain.menu.service.dto;

import java.util.List;

import backend.sudurukbackx6.ownerservice.domain.menu.entity.OptionsEntity;
import backend.sudurukbackx6.ownerservice.domain.menu.entity.enumTypes.Category;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class MenuRegisterRequest {
	private Long cafeId;
	private String name;
	private String description;
	private int price;
	private String img;
	private Category category;
	private List<OptionsEntity> optionsList;

}
