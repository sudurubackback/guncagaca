import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'basic/screen/landingpage.dart';
import 'login/screen/loginpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LandingPage()),
        GetPage(name: '/LoginPage', page: () => LoginPage()),
        // Add more GetPages as needed
      ],
      theme: ThemeData(fontFamily: 'Pretendard'),
    );
  }
}
