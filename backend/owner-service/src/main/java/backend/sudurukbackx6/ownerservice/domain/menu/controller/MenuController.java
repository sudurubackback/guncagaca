package backend.sudurukbackx6.ownerservice.domain.menu.controller;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import backend.sudurukbackx6.ownerservice.domain.menu.service.MenuService;
import backend.sudurukbackx6.ownerservice.domain.menu.service.dto.MenuEditRequest;
import backend.sudurukbackx6.ownerservice.domain.menu.service.dto.MenuRegisterRequest;
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
}
