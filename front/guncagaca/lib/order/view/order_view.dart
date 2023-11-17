import 'package:flutter/material.dart';
import 'package:guncagaca/order/component/order_list.dart';

import '../../kakao/main_view_model.dart';

class OrderView extends StatelessWidget{
  final MainViewModel mainViewModel;

  const OrderView({required this. mainViewModel});

  @override
  Widget build(BuildContext context) {
    return OrderList(mainViewModel: mainViewModel,);
  }
}