import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guncagaca/common/view/custom_appbar.dart';
import '../../kakao/main_view_model.dart';
import '../component/point_list.dart';


class PointScreen extends StatelessWidget {
  final MainViewModel mainViewModel;

  const PointScreen ({required this.mainViewModel});

  @override
  Widget build(BuildContext context) {


    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Color(0xfff8e9d7),
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
        child: CustomAppbar(title: '포인트함', imagePath: 'assets/image/point.png',)
      ),
      body: Column(
        children: [
          Expanded(
            child: PointList(),
          ),
        ],
      ),
    );

  }
}



