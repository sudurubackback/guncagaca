import 'package:flutter/material.dart';
import 'package:guncagaca/mypage/component/mypage_component.dart';
import 'package:guncagaca/mypage/controller/MypageController.dart';
import 'package:guncagaca/mypage/nickname.dart';
import 'package:guncagaca/myreview/view/review_screen.dart';
import 'package:guncagaca/point/view/point_screen.dart';

import '../../jjim/view/jjim_screen.dart';
import '../../kakao/main_view_model.dart';
import '../../login/loginpage.dart';
import '../../order/view/order_page.dart';




class MypageView extends StatelessWidget {
  final MainViewModel mainViewModel;

  const MypageView ({required this.mainViewModel});

  @override
  Widget build(BuildContext context) {
    MypageController mypageController = MypageController(mainViewModel: mainViewModel);

    return Scaffold(
      appBar: null,
      body: MypageComponent(
        onOrderTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrderPage(mainViewModel: mainViewModel,)),
          );
        },
        onReviewTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ReviewScreen(mainViewModel: mainViewModel,)),
          );
        },
        onJjimTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JjimScreen(mainViewModel: mainViewModel,)),
          );
        },
        onPointTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PointScreen(mainViewModel: mainViewModel,)),
          );
        },
        onNicknameTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NicknamePage(mainViewModel: mainViewModel,)),
          );
        },
        onLogoutTap: () {
          mypageController.showDialogLogOut(context);
        },
        onWithdrawalTap: () {
          mypageController.showOut(context);
        }, mainViewModel: mainViewModel,
      ),
    );
  }



}