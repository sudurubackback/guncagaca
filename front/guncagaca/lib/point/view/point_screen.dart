import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guncagaca/common/const/colors.dart';
import 'package:guncagaca/common/layout/custom_appbar.dart';
import '../../kakao/main_view_model.dart';
import '../component/point_list.dart';


class PointScreen extends StatelessWidget {
  final MainViewModel mainViewModel;

  const PointScreen ({required this.mainViewModel});

  @override
  Widget build(BuildContext context) {


    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: BACK_COLOR,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: CustomAppBar(title: '포인트함', mainViewModel: mainViewModel),
      body: Column(
        children: [
          Expanded(
            child: PointList(mainViewModel: mainViewModel,),
          ),
        ],
      ),
    );

  }
}



