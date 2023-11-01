import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:guncagaca/common/view/custom_appbar.dart';

import '../../kakao/main_view_model.dart';
import '../component/cart_footer.dart';
import '../component/cart_list.dart';
import '../controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  final MainViewModel mainViewModel;
  final CartController cartController = Get.find();

  CartScreen({required this.mainViewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
            child: CustomAppbar(title: '장바구니', imagePath: null,)
          ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: CartList()),
            Obx(() {
              if (cartController.cartItems.length > 0) {
                return CartFooter(mainViewModel: mainViewModel,);
              } else {
                return SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }
}

