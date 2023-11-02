import 'package:flutter/material.dart';

import 'orderprocessingpage.dart';

Map<String, dynamic> orderItemToMap(OrderItem orderItem) {
  return {
    "orderTime": orderItem.orderTime,
    "totalMenuCount": orderItem.totalMenuCount,
    "totalPrice": orderItem.totalPrice,
    "menuList": orderItem.menuList,
    "nickname": orderItem.nickname,
    "arrivalTime": orderItem.arrivalTime,
  };
}

class OrderDetailsModal extends StatelessWidget {
  final Map<String, dynamic> orderData;

  OrderDetailsModal(this.orderData);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(20),
      content: Container(
        width: 200,
        height: 280,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                '주문 정보',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                '닉네임: ${orderData["nickname"]}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                '주문 시간: ${orderData["orderTime"]}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                '메뉴 리스트:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Column(
                children: orderData["menuList"].map<Widget>((menu) {
                  return Text(
                    menu,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  );
                }).toList(),
              ),
              Text(
                '총 가격: ${orderData["totalPrice"]}원',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        // 모달 다이얼로그 액션 버튼 등을 추가할 수 있습니다.
      ],
    );
  }
}
