import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:guencagaca_onwer/login/screen/loginpage.dart';

class LandingPage extends StatefulWidget {


  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  void initState() {
    Timer(Duration(seconds: 2), (){
      Get.offAll(LoginPage());
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8E9D7),
      body: Center(
        child: Image.asset("assets/mainIcon.png"),
      ),
    );
  }
}
