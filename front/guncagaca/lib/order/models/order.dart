import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../menu/menu.dart';
import '../../menu/option.dart';

class Order {
  final Menu menu; // 기본 메뉴 정보
  final List<Option> selectedOptions; // 선택된 옵션들
  RxInt quantity = 1.obs;

  Order({required this.menu, required this.selectedOptions});
}
