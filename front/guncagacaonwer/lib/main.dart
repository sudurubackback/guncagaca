import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'basic/screen/landingpage.dart';
import 'common/ssecontroller.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  // SSE 초기화
  // SSEController sseController = SSEController();
  // await SSEController.setupApiService();
  await SSEController.connect();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
      theme: ThemeData(fontFamily: 'Pretendard'),
    );
  }
}

