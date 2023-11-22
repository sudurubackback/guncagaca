package backend.sudurukbackx6.ownerservice.domain.menu.service;


import backend.sudurukbackx6.ownerservice.common.s3.S3Uploader;
import backend.sudurukbackx6.ownerservice.domain.menu.entity.enumTypes.Category;
import org.springframework.beans.factory.annotation.Value;
import backend.sudurukbackx6.ownerservice.domain.menu.service.dto.*;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;
import backend.sudurukbackx6.ownerservice.domain.menu.entity.MenuEntity;
import backend.sudurukbackx6.ownerservice.domain.menu.entity.enumTypes.StatusMenu;
import backend.sudurukbackx6.ownerservice.domain.menu.repository.MenuRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

import java.util.*;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
@Transactional
public class MenuService {

	private final MenuRepository menuRepository;
	private final MongoTemplate mongoTemplate;
	private final S3Uploader s3Uploader;


	@Value("${cloud.aws.cloud.url}")
	private String basicProfile;

	public void createMenu(MultipartFile multipartFile, MenuRegisterRequest request) throws IOException {

		String upload = s3Uploader.upload(multipartFile, "MenuImages");

		MenuEntity menuEntity = MenuEntity.builder()
			.storeId(request.getCafeId()) // ownerId에서 storeid로 바꿔야합니다.
			.img(upload) //S3 연결 후 수정
			.category(request.getCategory())
			.description(request.getDescription())
			.name(request.getName())
			.price(request.getPrice())
			.optionsEntity(request.getOptionsList())
			.status(StatusMenu.ON_SALE)
			.build();

		menuRepository.save(menuEntity);
	}

	public void updateMenu(MultipartFile multipartFile, MenuEditRequest request) throws IOException {

		String upload = s3Uploader.upload(multipartFile, "MenuImages");

		MenuEntity menuEntity = menuRepository.findById(request.getId()).orElseThrow(RuntimeException::new);

		removeOriginFile(menuEntity);

		menuEntity.setName(request.getName());
		menuEntity.setDescription(request.getDescription());
		menuEntity.setPrice(request.getPrice());
		menuEntity.setCategory(request.getCategory());
		menuEntity.setImg(upload); //S3 연결 후 수정
		menuEntity.setOptionsEntity(request.getOptionsList());

		menuRepository.save(menuEntity);
	}

	//
	private void removeOriginFile(MenuEntity menuEntity) {
		String img = menuEntity.getImg();
		String[] split = img.split("/");
		int length = split.length;
		img = split[length-1];
		s3Uploader.deleteFile("MenuImages/" + img);
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
		removeOriginFile(menuEntity);
		menuRepository.delete(menuEntity);
	}

	public String uploadTest(MultipartFile multipartFile) throws IOException {

		String upload = s3Uploader.upload(multipartFile, "Test");

		return "성공 " + upload;
	}

	// 카테고리별로 메뉴 반환
	public Map<Category, List<MenuEntity>> getMenuGroupByCategory(Long storeId) {
		 List<MenuEntity> menus = menuRepository.findByStoreId(storeId);

		 Map<Category, List<MenuEntity>> groupByCategory = menus.stream()
				 .collect(Collectors.groupingBy(MenuEntity::getCategory));

		 return groupByCategory;
	}

}
