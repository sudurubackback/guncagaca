package backend.sudurukbackx6.ownerservice.domain.menu.service;


import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;
import backend.sudurukbackx6.ownerservice.domain.menu.entity.MenuEntity;
import backend.sudurukbackx6.ownerservice.domain.menu.entity.enumTypes.StatusMenu;
import backend.sudurukbackx6.ownerservice.domain.menu.repository.MenuRepository;
import backend.sudurukbackx6.ownerservice.domain.menu.service.dto.MenuEditRequest;
import backend.sudurukbackx6.ownerservice.domain.menu.service.dto.MenuRegisterRequest;
import backend.sudurukbackx6.ownerservice.domain.owner.service.OwnerService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class MenuService {

	private final MenuRepository menuRepository;
	private final OwnerService ownerService;
	private final MongoTemplate mongoTemplate;
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

		MenuEntity menuEntity = menuRepository.findById(id).orElseThrow();

		//Spring id의 status값에 따라서 상태가 바뀐다. 3항연산자 써볼지두..?
		Query query = new Query(Criteria.where("_id").is(id));
		Update update = new Update();
		update.set("status", menuEntity.getStatus()==StatusMenu.ON_SALE?StatusMenu.SOLD_OUT:StatusMenu.ON_SALE);
		mongoTemplate.updateFirst(query, update, MenuEntity.class);

	}

	public void deleteMenu(String id) {
		MenuEntity menuEntity = menuRepository.findById(id).orElseThrow();
		menuRepository.delete(menuEntity);
	}
}
