import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:guncagaca/common/layout/default_layout.dart';
import 'package:guncagaca/common/view/root_tab.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:guncagaca/login/landingpage.dart';

import 'cart/controller/cart_controller.dart';

void main() {
  KakaoSdk.init(nativeAppKey: 'a401e9c33cb071b374c233a8f026060c');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Color(0xfff8e9d7),
      statusBarIconBrightness: Brightness.dark,
    ));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      // home: DefaultLayout(child: RootTab()),
      home: LandingPage(),
      initialBinding: AppBinding(),
      theme: ThemeData(
          fontFamily: 'omu',
      ),
      themeMode: ThemeMode.system,
    );
  }
}

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CartController());
  }
}