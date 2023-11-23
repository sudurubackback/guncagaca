import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guncagaca/common/const/colors.dart';
import 'package:guncagaca/login/loginpage.dart';
import 'package:permission_handler/permission_handler.dart';

class LandingPage extends StatefulWidget {

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    requestLocationPermission();
    Timer(Duration(seconds: 3),() {
      Get.to(() => LoginPage());
    });
    // TODO: implement initState
    super.initState();
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      // 권한 허용됨
    } else if (status.isDenied) {
      // 권한 거부됨
    } else if (status.isPermanentlyDenied) {
      // 권한 영구 거부됨, 앱 설정으로 사용자를 안내
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: BACK_COLOR,
        child: Center(
          child: Image.asset('assets/image/main_img.png'),
        ),
      ),
    );
  }
}