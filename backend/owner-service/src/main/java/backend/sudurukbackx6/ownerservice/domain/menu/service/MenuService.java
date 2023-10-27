package backend.sudurukbackx6.ownerservice.domain.menu.service;

import java.util.List;

import javax.persistence.EntityNotFoundException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import backend.sudurukbackx6.ownerservice.domain.menu.entity.DetailsOptionEntity;
import backend.sudurukbackx6.ownerservice.domain.menu.entity.MenuEntity;
import backend.sudurukbackx6.ownerservice.domain.menu.entity.OptionsEntity;
import backend.sudurukbackx6.ownerservice.domain.menu.entity.enumTypes.Category;
import backend.sudurukbackx6.ownerservice.domain.menu.entity.enumTypes.StatusMenu;
import backend.sudurukbackx6.ownerservice.domain.menu.repository.MenuRepository;
import backend.sudurukbackx6.ownerservice.domain.menu.service.dto.MenuEditRequest;
import backend.sudurukbackx6.ownerservice.domain.menu.service.dto.MenuRegisterRequest;
import backend.sudurukbackx6.ownerservice.domain.owner.entity.Owners;
import backend.sudurukbackx6.ownerservice.domain.owner.service.OwnerService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class MenuService {

	private final MenuRepository menuRepository;
	private final OwnerService ownerService;
	public void createMenu(MenuRegisterRequest request) {

		MenuEntity menuEntity = MenuEntity.builder()
			.storeId(request.getCafeId()) // ownerId에서 storeid로 바꿔야합니다.
			.img("이미지") //S3 연결 후 수정
			.category(request.getCategory())
			.name(request.getName())
			.price(request.getPrice())
			.optionsEntity(request.getOptionsList())
			.status(StatusMenu.ON_SALE)
			.build();

		menuRepository.save(menuEntity);
	}

	public void updateMenu(MenuEditRequest request) {
		MenuEntity menuEntity = menuRepository.findById(request.getId()).orElseThrow(RuntimeException::new);
		menuEntity.setName(request.getName());
		menuEntity.setPrice(request.getPrice());
		menuEntity.setCategory(request.getCategory());
		menuEntity.setImg("이미지"); //S3 연결 후 수정
		menuEntity.setOptionsEntity(request.getOptionsList());

		menuRepository.save(menuEntity);
	}

	public void updateStatus(String id) {
		log.info("id = {}", id);
		MenuEntity menuEntity = menuRepository.findById(id).orElseThrow();
		log.info("=========================");
		log.info("menuEntity = {}", menuEntity);
		log.info("=========================");
		if (menuEntity.getStatus().equals(StatusMenu.ON_SALE)) {
			log.info("=========들어옴? ===========");
			menuEntity.setStatus(StatusMenu.SOLD_OUT);
			menuRepository.save(menuEntity);
		} else {
			log.info("=========들어옴? ===========222");
			menuEntity.setStatus(StatusMenu.ON_SALE);
			menuRepository.save(menuEntity);
		}
	}

	public void deleteMenu(String id) {
		MenuEntity menuEntity = menuRepository.findById(id).orElseThrow();
		menuRepository.delete(menuEntity);
	}
}
