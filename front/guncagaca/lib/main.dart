import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:guncagaca/login/landingpage.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../common/utils/oauth_token_manager.dart' as KakaoTokenManager;

import 'cart/controller/cart_controller.dart';
import 'firebase_options.dart';

void main() async {
  await dotenv.load(fileName: ".env");	// .env 파일 Path
  KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_SDK_NATIVE_KEY']);
  WidgetsFlutterBinding.ensureInitialized();
  await KakaoTokenManager.TokenManager().initialize();
  runApp(const MyApp());
  initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
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