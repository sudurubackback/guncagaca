import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:guncagaca/order/models/order_option.dart';

import '../../menu/menu.dart';
import '../../menu/option.dart';

class Order {
  final String name;
  final int totalPrice;
  final String img;
  final String storeName;
  final List<OrderOption>? selectedOptions; // 선택된 옵션들
  RxInt quantity = 1.obs;

  Order({
    required this.name,
    required this.totalPrice,
    required this.img,
    required this.storeName,
    required this.selectedOptions});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Order &&
      other.name == name &&
        _areOptionListsEqual(other.selectedOptions, selectedOptions);
  }

  bool _areOptionListsEqual(List<OrderOption>? list1, List<OrderOption>? list2) {
    if (list1 == null && list2 == null) return true;
    if (list1 == null || list2 == null) return false;

    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode => name.hashCode ^ selectedOptions.hashCode;
}
