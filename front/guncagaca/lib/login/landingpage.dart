import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guncagaca/login/loginpage.dart';

class LandingPage extends StatefulWidget {

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 3),() {
      Get.to(LoginPage());
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xfff8e9d7),
        child: Center(
          child: Image.asset('assets/image/main_img.png'),
        ),
      ),
    );
  }
}