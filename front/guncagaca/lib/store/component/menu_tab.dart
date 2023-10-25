import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../cart/controller/cart_controller.dart';
import '../models/menu.dart';
import 'menu_card.dart';

class MenuTabWidget extends StatelessWidget {
  final List<Menu> menus;

  const MenuTabWidget({super.key, required this.menus});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());

    return ListView.builder(
      itemCount: menus.length,
      itemBuilder: (BuildContext context, int index) {
        return MenuCard(
          menu: menus[index],
          onAddToCart: () {
            cartController.addToCart(menus[index]);
          },
        );
      },
    );
  }
}
