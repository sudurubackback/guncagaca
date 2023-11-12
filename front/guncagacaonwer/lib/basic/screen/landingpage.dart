import 'dart:async';
import 'package:flutter/material.dart';
import 'package:guncagacaonwer/login/screen/loginpage.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      _navigateToLoginPage();
    });
    super.initState();
  }

  void _navigateToLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  Widget _buildScreenContent() {
    Size screenSize = MediaQuery.of(context).size;
    double imageWidth;
    double imageHeight;

    if (screenSize.width >= 2700) {
      imageWidth = 900;
      imageHeight = 720;
    } else if (screenSize.width >= 2400) {
      imageWidth = 800;
      imageHeight = 640;
    } else if (screenSize.width >= 2100) {
      imageWidth = 700;
      imageHeight = 560;
    } else if (screenSize.width >= 1800) {
      imageWidth = 600;
      imageHeight = 480;
    } else if (screenSize.width >= 1500) {
      imageWidth = 500;
      imageHeight = 400;
    } else if (screenSize.width >= 1200) {
      imageWidth = 400;
      imageHeight = 320;
    } else if (screenSize.width >= 900) {
      imageWidth = 300;
      imageHeight = 240;
    } else {
      imageWidth = 200;
      imageHeight = 160;
    }

    return Image.asset(
      "assets/mainIcon.png",
      width: imageWidth,
      height: imageHeight,
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
