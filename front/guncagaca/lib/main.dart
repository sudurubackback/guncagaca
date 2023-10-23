import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:guncagaca/common/layout/default_layout.dart';
import 'package:guncagaca/common/view/root_tab.dart';
import 'package:guncagaca/landingpage.dart';

void main() {
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
      home: DefaultLayout(child: RootTab()),
      theme: ThemeData(
          fontFamily: 'omu'),
      themeMode: ThemeMode.system,
    );
  }
}