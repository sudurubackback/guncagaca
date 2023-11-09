import 'package:get/get.dart';

import '../../order/models/order_menu.dart';

class CartController extends GetxController {
  RxList<OrderMenu> cartItems = RxList<OrderMenu>();
  RxMap<OrderMenu, int> itemQuantities = RxMap<OrderMenu, int>();

  var selectedOption = '포장'.obs;
  var selectedTime = 10.obs;

  void setSelectedOption(String value) {
    selectedOption.value = value;
  }

  void setSelectedTime(int value) {
    selectedTime.value = value;
  }

  int get totalPrice {
    return cartItems.fold(0, (prev, order) => prev + order.totalPrice * order.quantity.value);
  }

  void addToCart(OrderMenu order) {
    OrderMenu? existingOrder;
    try {
      existingOrder = cartItems.firstWhere((o) => o == order);
    } catch (e) {
      existingOrder = null;
    }

    if (existingOrder != null) {
      increaseQuantity(existingOrder);
    } else {
      order.quantity = RxInt(1);
      cartItems.add(order);
    }
  }

  void removeFromCart(OrderMenu order) {
    cartItems.remove(order);
  }

  void increaseQuantity(OrderMenu order) {
    print('개수 추가');
    order.quantity.value++;
  }

  void decreaseQuantity(OrderMenu order) {
    print('개수 감소');
    if (order.quantity.value > 1) {
      order.quantity.value--;
    } else {
      removeFromCart(order);
    }
  }

  int get itemCount => cartItems.length;
}
