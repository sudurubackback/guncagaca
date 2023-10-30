import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../store/models/menu.dart';

class CartController extends GetxController {

  RxList<Menu> cartItems = RxList<Menu>();
  RxMap<Menu, int> itemQuantities = RxMap<Menu, int>();

  var selectedOption = '포장'.obs;

  void setSelectedOption(String value) {
    selectedOption.value = value;
  }

  var selectedTime = '10분'.obs;

  void setSelectedTime(String value) {
    selectedTime.value = value;
  }

  int get totalPrice {
    return cartItems.fold(0, (prev, item) => prev + item.price * (itemQuantities[item] ?? 1));
  }

  void addToCart(Menu menu) {
    if (!cartItems.contains(menu)) {
      cartItems.add(menu);
      itemQuantities[menu] = 1; // 초기 수량 설정
    } else {
      increaseQuantity(menu);  // 메뉴가 이미 있으면 수량만 증가
    }
  }

  void removeFromCart(Menu menu) {
    cartItems.remove(menu);
    itemQuantities.remove(menu);
  }

  void increaseQuantity(Menu menu) {
    itemQuantities[menu] = (itemQuantities[menu] ?? 0) + 1;
  }

  void decreaseQuantity(Menu menu) {
    if (itemQuantities[menu]! > 1) {
      itemQuantities[menu] = itemQuantities[menu]! - 1;
    } else {
      removeFromCart(menu);
    }
  }

  int get itemCount => cartItems.length;
}