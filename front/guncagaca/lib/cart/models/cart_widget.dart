import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../common/const/colors.dart';
import '../../common/layout/default_layout.dart';
import '../controller/cart_controller.dart';
import '../view/cart_screen.dart';

class CartIconWidget extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        IconButton(
          icon: Icon(Icons.shopping_cart, color: PRIMARY_COLOR, size: 28.0),
          onPressed: () {
            FocusScope.of(context).unfocus();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DefaultLayout(
                    title: '장바구니',
                    child: CartScreen()),
              ),
            );
          },
        ),
        Obx(() {
          if (cartController.cartItems.length == 0) {
            return SizedBox.shrink();
          }

          return Positioned(
            right: 8,
            top: 8,
            child: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.red,
              child: Text(
                cartController.cartItems.length.toString(),
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
