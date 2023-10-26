import 'package:flutter/material.dart';

import '../component/cart_footer.dart';
import '../component/cart_list.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: CartList()),  // 화면의 대부분을 차지
            CartFooter(),// 바텀바로 표시
          ],
        ),
      ),
    );
  }
}

