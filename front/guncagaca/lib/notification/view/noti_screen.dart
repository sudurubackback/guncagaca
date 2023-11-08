import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guncagaca/common/view/custom_appbar.dart';
import '../component/noti_list.dart';

class NotiScreen extends StatelessWidget {
  final List<Map<String, dynamic>> notifications;

  NotiScreen({required this.notifications});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Color(0xfff8e9d7),
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
        child: CustomAppbar(title: '알림함',imagePath: 'assets/image/noti.png',)
      ),
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



