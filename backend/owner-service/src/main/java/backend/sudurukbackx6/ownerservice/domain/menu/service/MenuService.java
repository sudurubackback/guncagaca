package backend.sudurukbackx6.ownerservice.domain.menu.service;


import backend.sudurukbackx6.ownerservice.common.s3.S3Uploader;
import org.springframework.beans.factory.annotation.Value;
import backend.sudurukbackx6.ownerservice.domain.menu.entity.DetailsOptionEntity;
import backend.sudurukbackx6.ownerservice.domain.menu.entity.OptionsEntity;
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
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

@Service
@Slf4j
@RequiredArgsConstructor
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
		menuRepository.delete(menuEntity);
	}

	public String uploadTest(MultipartFile multipartFile) throws IOException {

		String upload = s3Uploader.upload(multipartFile, "Test");

		return "성공 " + upload;
	}

	public OrderResponseDto getOrder (OrderRequestDto orderRequestDto) {
		List<MenuRequestDto> menus = orderRequestDto.getMenus();

		List<MenuResponseDto> menuList = new ArrayList<>();
		for (MenuRequestDto menuRequestDto : menus) {
			MenuEntity menuEntity = menuRepository.findById(menuRequestDto.getMenuId())
					.orElseThrow(() -> new IllegalArgumentException("메뉴 아이디가 일치하지 않습니다."));
			log.info(menuEntity.getName());
			List<int[]> optionsList = new ArrayList<>();

			// 옵션
			List<OptionsEntity> optionsEntity = menuEntity.getOptionsEntity();
			for (int i = 0; i<optionsEntity.size(); i++) {
				for (OptionRequestDto optionRequestDto : menuRequestDto.getOptions()) {
					if (optionsEntity.get(i).getOptionName().equals(optionRequestDto.getOptionName())) {
						log.info("in option");
						// 인덱스 설정
						int[] arr = new int[2];
						arr[0] = i;

						// 디테일 옵션
						List<DetailsOptionEntity> detailsOptions = optionsEntity.get(i).getDetailsOptions();
						for (int j = 0; j<detailsOptions.size(); j++) {
							for (DetailOptionRequestDto detailOptionRequestDto : optionRequestDto.getDetailOptions()) {
								log.info(detailsOptions.get(j).getDetailOptionName());
								log.info(detailOptionRequestDto.getDetailOptionName());
								if (detailsOptions.get(j).getDetailOptionName().equals(detailOptionRequestDto.getDetailOptionName())) {
									log.info("in detail option");
									arr[1] = j;
									optionsList.add(arr);
								}
							}
						}
					}
				}
			}
			log.info("out");
			MenuResponseDto menuResponseDto = MenuResponseDto.builder()
					.menuId(menuRequestDto.getMenuId())
					.name(menuRequestDto.getName())
					.price(menuRequestDto.getPrice())
					.totalPrice(menuRequestDto.getTotalPrice())
					.quantity(menuRequestDto.getQuantity())
					.img(menuRequestDto.getImg())
					.category(menuRequestDto.getCategory())
					.options(optionsList)
					.build();
			menuList.add(menuResponseDto);
		}

		return OrderResponseDto.builder()
				.memberId(orderRequestDto.getMemberId())
				.storeId(orderRequestDto.getStoreId())
				.orderPrice(orderRequestDto.getOrderPrice())
				.menus(menuList)
				.build();
	}
}
