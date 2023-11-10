import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guncagaca/common/const/colors.dart';
import 'package:guncagaca/common/layout/custom_appbar.dart';
import '../../kakao/main_view_model.dart';
import '../component/noti_list.dart';

class NotiScreen extends StatelessWidget {
  final MainViewModel mainViewModel;

  const NotiScreen({required this.mainViewModel});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: BACK_COLOR,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: CustomAppBar(title: "알림함", mainViewModel: mainViewModel),
      body: Column(
        children: [
          Expanded(
            child: NotiList(),
          ),
        ],
      ),
    );
  }
}



