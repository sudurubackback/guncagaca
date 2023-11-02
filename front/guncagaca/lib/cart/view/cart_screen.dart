import 'package:flutter/material.dart';

import '../component/cart_footer.dart';
import '../component/cart_list.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CartList(),
      // bottomNavigationBar: BottomAppBar(
      //   child: CartBottomBar(),
      //   elevation: 6.0,
      // ),
    );
  }
}

