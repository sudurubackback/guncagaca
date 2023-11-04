import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guncagaca/common/view/custom_appbar.dart';
import 'package:guncagaca/order/component/order_component.dart';

import '../../kakao/main_view_model.dart';
import '../../menu/menu_detail.dart';


class OrderPage extends StatelessWidget {
  final MainViewModel mainViewModel;

  const OrderPage({required this.mainViewModel});

  @override
  Widget build(BuildContext context) {


    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Color(0xfff8e9d7),
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
        child: CustomAppbar(title: '주문내역',imagePath: null,),
      ),
      body: Column(
        children: [
          Expanded(
            child: OrderList(mainViewModel: mainViewModel,),
          ),
        ],
      ),
    );

  }
}