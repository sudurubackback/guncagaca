
import 'package:guncagaca/order/models/order_menu.dart';

import '../../menu/menu.dart';

class OrderRequest {
  final String receiptId;
  final int storeId;
  final bool takeoutYn;
  final int totalOrderPrice;
  final int eta;
  final String payMethod;
  final List<OrderMenu> menus;

  OrderRequest({
    required this.receiptId,
    required this.storeId,
    required this.takeoutYn,
    required this.eta,
    required this.payMethod,
    required this.totalOrderPrice,
    required this.menus,
  });

  Map<String, dynamic> toJson() => {
    'receiptId': receiptId,
    'storeId': storeId,
    'takeoutYn': takeoutYn,
    'eta': eta,
    'payMethod': payMethod,
    'totalOrderPrice': totalOrderPrice,
    'menus': menus.map((orderMenu) => orderMenu.toJson()).toList(),
  };
}