import 'package:guncagaca/order/models/order_menu.dart';

// 조회할 주문 내역
class OrderHistory {
  final String orderId;
  final int storeId;
  final DateTime orderTime;
  final String receiptId;
  final String status;
  final bool takeoutYn;
  final bool reviewYn;
  final int eta;
  final String payMethod;
  final List<OrderMenu> menus;
  final int price;

  OrderHistory({
    required this.eta,
    required this.orderId,
    required this.storeId,
    required this.orderTime,
    required this.receiptId,
    required this.status,
    required this.payMethod,
    required this.takeoutYn,
    required this.reviewYn,
    required this.menus,
    required this.price,
  });

  factory OrderHistory.fromJson(Map<String, dynamic> json) {
    return OrderHistory(
      eta: json['eta'],
      orderId: json['id'],
      storeId: json['storeId'],
      payMethod: json['payMethod'],
      orderTime: DateTime.parse(json['orderTime']),
      receiptId: json['receiptId'],
      status: json['status'],
      takeoutYn: json['takeoutYn'],
      reviewYn: json['reviewYn'],
      menus: (json['menus'] as List).map((menuJson) => OrderMenu.fromJson(menuJson)).toList(),
      price: json['price'],
    );
  }

  Map<String, dynamic> toModel() {
    return {
      'eta': eta,
      'orderId': orderId,
      'storeId': storeId,
      'orderTime': orderTime.toIso8601String(),
      'receiptId': receiptId,
      'status': status,
      'payMethod': payMethod,
      'takeoutYn': takeoutYn,
      'reviewYn': reviewYn,
      'menus': menus.map((menu) => menu.toModel()).toList(),
      'price': price,
    };
  }

}