import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guncagacaonwer/login/screen/loginpage.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      Get.offAll(LoginPage());
    });
    super.initState();
  }

  Widget _buildScreenContent() {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width >= 2700) {
      return _buildSuperHugeScreenContent();
    } else if (screenSize.width >= 2400) {
      return _buildExtraHugeScreenContent();
    } else if (screenSize.width >= 2100) {
      return _buildHugeScreenContent();
    } else if (screenSize.width >= 1800) {
      return _buildXLargeScreenContent();
    } else if (screenSize.width >= 1500) {
      return _buildLargeScreenContent();
    } else if (screenSize.width >= 1200) {
      return _buildMediumScreenContent();
    } else if (screenSize.width >= 900) {
      return _buildSmallScreenContent();
    } else {
      return _buildXSmallScreenContent();
    }
  }

  Widget _buildSuperHugeScreenContent() {
    // 가로 너비가 2700 이상인 경우 처리
    return Image.asset(
      "assets/mainIcon.png",
      width: 900, // 원하는 너비로 조절
      height: 720, // 원하는 높이로 조절
    );
  }

  Widget _buildExtraHugeScreenContent() {
    // 가로 너비가 2400 이상 2700 미만인 경우 처리
    return Image.asset(
      "assets/mainIcon.png",
      width: 800, // 원하는 너비로 조절
      height: 640, // 원하는 높이로 조절
    );
  }

  Widget _buildHugeScreenContent() {
    // 가로 너비가 2100 이상 2400 미만인 경우 처리
    return Image.asset(
      "assets/mainIcon.png",
      width: 700, // 원하는 너비로 조절
      height: 560, // 원하는 높이로 조절
    );
  }

  Widget _buildXLargeScreenContent() {
    // 가로 너비가 1800 이상 2100 미만인 경우 처리
    return Image.asset(
      "assets/mainIcon.png",
      width: 600, // 원하는 너비로 조절
      height: 480, // 원하는 높이로 조절
    );
  }

  Widget _buildLargeScreenContent() {
    // 가로 너비가 1500 이상 1800 미만인 경우 처리
    return Image.asset(
      "assets/mainIcon.png",
      width: 500, // 원하는 너비로 조절
      height: 400, // 원하는 높이로 조절
    );
  }

  Widget _buildMediumScreenContent() {
    // 가로 너비가 1200 이상 1500 미만인 경우 처리
    return Image.asset(
      "assets/mainIcon.png",
      width: 400, // 원하는 너비로 조절
      height: 320, // 원하는 높이로 조절
    );
  }

  Widget _buildSmallScreenContent() {
    // 가로 너비가 900 이상 1200 미만인 경우 처리
    return Image.asset(
      "assets/mainIcon.png",
      width: 300, // 원하는 너비로 조절
      height: 240, // 원하는 높이로 조절
    );
  }

  Widget _buildXSmallScreenContent() {
    // 가로 너비가 900 미만인 경우 처리
    return Image.asset(
      "assets/mainIcon.png",
      width: 200, // 원하는 너비로 조절
      height: 160, // 원하는 높이로 조절
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8E9D7),
      body: Center(
        child: _buildScreenContent(),
      ),
    );
  }
}
