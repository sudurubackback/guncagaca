package backend.sudurukbackx6.ownerservice.domain.menu.controller;

import backend.sudurukbackx6.ownerservice.domain.menu.service.dto.*;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import backend.sudurukbackx6.ownerservice.domain.menu.service.MenuService;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/ceo")
@RequiredArgsConstructor
public class MenuController {
	private final MenuService menuService;

	@PostMapping("/menu/register")
	public void createMenu(@RequestBody MenuRegisterRequest request){
		menuService.createMenu(request);
	}

	@PutMapping("/menu/edit")
	public void updateMenu(@RequestBody MenuEditRequest request){
		menuService.updateMenu(request);
	}

	@PutMapping("/menu/sale")
	public void updateStatus(@RequestBody String menuId){
		menuService.updateStatus(menuId);
	}

	@DeleteMapping("/menu/delete")
	public void deleteMenu(@RequestBody String menuId){
		menuService.deleteMenu(menuId);
	}

	@GetMapping("/menu/order")
	public ResponseEntity<OrderResponseDto> getOrder(@RequestBody OrderRequestDto orderRequestDto) {
		return ResponseEntity.ok(menuService.getOrder(orderRequestDto));
	}
}
