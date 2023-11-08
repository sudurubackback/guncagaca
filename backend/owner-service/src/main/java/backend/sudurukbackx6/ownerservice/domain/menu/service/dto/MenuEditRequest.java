package backend.sudurukbackx6.ownerservice.domain.menu.service.dto;

import java.util.List;

import backend.sudurukbackx6.ownerservice.domain.menu.entity.OptionsEntity;
import backend.sudurukbackx6.ownerservice.domain.menu.entity.enumTypes.Category;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class MenuEditRequest {
	private String id;
	private String name;
	private int price;
	private String description;
	private String img;
	private Category category;
	private List<OptionsEntity> optionsList;
}
