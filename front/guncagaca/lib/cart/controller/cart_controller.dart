import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../menu/option.dart';
import '../../order/models/order.dart';

class CartController extends GetxController {
  RxList<Order> cartItems = RxList<Order>();
  RxMap<Order, int> itemQuantities = RxMap<Order, int>();

  var selectedOption = '포장'.obs;
  var selectedTime = '10분'.obs;

  void setSelectedOption(String value) {
    selectedOption.value = value;
  }

  void setSelectedTime(String value) {
    selectedTime.value = value;
  }

  int get totalPrice {
    return cartItems.fold(0, (prev, order) => prev + order.menu.initPrice * order.quantity.value);
  }

  void addToCart(Order order) {
    Order? existingOrder;
    try {
      existingOrder = cartItems.firstWhere((o) => o.menu == order.menu && _areOptionListsEqual(o.selectedOptions, order.selectedOptions));
    } catch (e) {
      // 해당하는 Order가 없음
    }

    if (existingOrder == null) {
      order.quantity.value = 1;  // 여기에서 quantity를 초기화합니다.
      cartItems.add(order);
    } else {
      increaseQuantity(existingOrder);
    }
  }

  void removeFromCart(Order order) {
    cartItems.remove(order);
  }

  void increaseQuantity(Order order) {
    print('개수 추가');
    order.quantity.value++;
  }

  void decreaseQuantity(Order order) {
    print('개수 감소');
    if (order.quantity.value > 1) {
      order.quantity.value--;
    } else {
      removeFromCart(order);
    }
  }

  bool _areOptionListsEqual(List<Option> list1, List<Option> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }

  int get itemCount => cartItems.length;
}
