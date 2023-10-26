package backend.sudurukbackx6.ownerservice.domain.menu.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import backend.sudurukbackx6.ownerservice.domain.menu.service.MenuService;
import backend.sudurukbackx6.ownerservice.domain.menu.service.dto.MenuRegisterRequest;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/menu")
@RequiredArgsConstructor
public class MenuController {
	private final MenuService menuService;

	@PostMapping("/register")
	public void createMenu(@RequestBody MenuRegisterRequest request){
		menuService.createMenu(request);
	}

}
