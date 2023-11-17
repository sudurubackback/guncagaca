import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/const/colors.dart';
import '../../kakao/main_view_model.dart';
import '../controller/cart_controller.dart';
import '../view/cart_screen.dart';

class CartIconWidget extends StatelessWidget {
  final MainViewModel mainViewModel;
  final CartController cartController = Get.find<CartController>();

  CartIconWidget({required this.mainViewModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        IconButton(
          icon: Icon(Icons.shopping_cart, color: PRIMARY_COLOR, size: 28.0),
          onPressed: () {
            FocusScope.of(context).unfocus();
            Get.to(() => CartScreen(mainViewModel: mainViewModel));
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
