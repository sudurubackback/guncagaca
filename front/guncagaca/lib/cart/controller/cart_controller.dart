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
    return cartItems.fold(0, (prev, order) => prev + order.totalPrice * order.quantity.value);
  }

  void addToCart(Order order) {
    Order? existingOrder;
    try {
      existingOrder = cartItems.firstWhere((o) => o == order);
    } catch (e) {
      existingOrder = null;
    }

    if (existingOrder != null) {
      increaseQuantity(existingOrder);
    } else {
      order.quantity = RxInt(1); // 새로운 주문 항목의 경우, 수량을 1로 초기화
      cartItems.add(order);
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

  int get itemCount => cartItems.length;
}
