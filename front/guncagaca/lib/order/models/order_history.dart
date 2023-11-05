import 'package:flutter/material.dart';
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
  final List<OrderMenu> menus;
  final int price;

  OrderHistory({
    required this.orderId,
    required this.storeId,
    required this.orderTime,
    required this.receiptId,
    required this.status,
    required this.takeoutYn,
    required this.reviewYn,
    required this.menus,
    required this.price,
  });
}