package backend.sudurukbackx6.ownerservice.domain.menu.controller;

import org.springframework.http.MediaType;
import backend.sudurukbackx6.ownerservice.domain.menu.service.dto.*;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import backend.sudurukbackx6.ownerservice.domain.menu.service.MenuService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@RestController
@RequestMapping("/api/ceo")
@RequiredArgsConstructor
public class MenuController {
	private final MenuService menuService;

	@PostMapping(value = "/menu/register", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
	public void createMenu(@RequestPart(value="file", required = false) MultipartFile file, @RequestPart MenuRegisterRequest request) throws IOException {
		menuService.createMenu(file, request);
	}

	@PutMapping(value = "/menu/edit",consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
	public void updateMenu(@RequestPart(value="file", required = false) MultipartFile file, @RequestPart MenuEditRequest request) throws IOException {
		menuService.updateMenu(file, request);
	}

	@PutMapping("/menu/sale")
	public void updateStatus(@RequestBody String menuId){
		menuService.updateStatus(menuId);
	}

	@DeleteMapping("/menu/delete")
	public void deleteMenu(@RequestBody String menuId){
		menuService.deleteMenu(menuId);
	}

	@PostMapping(value = "/image",consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
	public String uploadTest(@RequestPart(value="file", required = false) MultipartFile file) throws IOException {
		return menuService.uploadTest(file);
	}

	@PostMapping("/menu/order")
	public ResponseEntity<OrderResponseDto> getOrder(@RequestBody OrderRequestDto orderRequestDto) {
		return ResponseEntity.ok(menuService.getOrder(orderRequestDto));
	}
}
