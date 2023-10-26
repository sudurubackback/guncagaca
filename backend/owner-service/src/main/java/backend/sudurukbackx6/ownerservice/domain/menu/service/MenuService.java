package backend.sudurukbackx6.ownerservice.domain.menu.service;

import java.util.List;

import org.springframework.stereotype.Service;

import backend.sudurukbackx6.ownerservice.domain.menu.entity.DetailsOptionEntity;
import backend.sudurukbackx6.ownerservice.domain.menu.entity.MenuEntity;
import backend.sudurukbackx6.ownerservice.domain.menu.entity.OptionsEntity;
import backend.sudurukbackx6.ownerservice.domain.menu.repository.DetailOptionRepository;
import backend.sudurukbackx6.ownerservice.domain.menu.repository.MenuRepository;
import backend.sudurukbackx6.ownerservice.domain.menu.repository.OptionsRepository;
import backend.sudurukbackx6.ownerservice.domain.menu.service.dto.MenuRegisterRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class MenuService {

	private final MenuRepository menuRepository;
	private final OptionsRepository optionsRepository;
	private final DetailOptionRepository detailOptionRepository;

	public void createMenu(MenuRegisterRequest request) {

		MenuEntity menuEntity = MenuEntity.builder()
			.name(request.getName())
			.price(request.getPrice())
			.optionsEntity(request.getOptionsList())
			.build();

		menuRepository.save(menuEntity);

		log.info("MenuEntity: {}", menuEntity);

		List<OptionsEntity> optionsList = request.getOptionsList();

		optionsRepository.saveAll(optionsList);

		log.info("OptionsEntity: {}", optionsList);

		for (OptionsEntity optionsEntity : optionsList) {
			List<DetailsOptionEntity> detailsOptions = optionsEntity.getDetailsOptions();
			detailOptionRepository.saveAll(detailsOptions);
		}
	}
}
