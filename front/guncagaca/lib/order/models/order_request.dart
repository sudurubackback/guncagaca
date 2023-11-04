
import 'package:guncagaca/order/models/order_menu.dart';

import '../../menu/menu.dart';

class OrderRequest {
  final String receiptId;
  final int storeId;
  final bool takeoutYn;
  final int totalOrderPrice;
  final List<OrderMenu> menus;

  OrderRequest({
    required this.receiptId,
    required this.storeId,
    required this.takeoutYn,
    required this.totalOrderPrice,
    required this.menus,
  });

  Map<String, dynamic> toJson() => {
    'receiptId': receiptId,
    'storeId': storeId,
    'takeoutYn': takeoutYn,
    'totalOrderPrice': totalOrderPrice,
    'menus': menus.map((orderMenu) => orderMenu.toJson()).toList(),
  };
}