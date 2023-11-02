import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:guncagaca/common/const/colors.dart';

import '../../menu/menu.dart';
import '../controller/cart_controller.dart';
import 'cart_item.dart';

class CartList extends StatelessWidget {
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (cartController.cartItems.isEmpty) {
        return Center(child: Text("장바구니가 비어있습니다."));
      }

      return Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              cartController.cartItems[0].storeName, // 예시로 넣은 가게이름. 실제 데이터로 대체 필요.
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(color: PRIMARY_COLOR, thickness: 2.0,),
          Expanded(
            child: ListView.builder(
              itemCount: cartController.cartItems.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    CartItem(item: cartController.cartItems[index]),  // 여러분의 CartItem 위젯
                    if (index != cartController.cartItems.length - 1)  // 마지막 아이템이 아닐 때만 구분선 추가
                      Divider(color: Colors.grey, thickness: 1.0,),
                  ],
                );
              },
            ),
          )
        ],
      );
    });
  }
}


