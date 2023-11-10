import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:guncagaca/common/const/colors.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:guncagaca/login/landingpage.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../common/utils/oauth_token_manager.dart' as KakaoTokenManager;

import 'cart/controller/cart_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'common/fcm/fcmsetting.dart'; // fcmSetting 함수를 호출할 파일을 import

void main() async {
  await dotenv.load(fileName: ".env"); // .env 파일 Path
  KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_SDK_NATIVE_KEY']);

  await fcmSetting(); // FCM 설정 초기화

  await KakaoTokenManager.TokenManager().initialize();

  await NaverMapSdk.instance.initialize(
      clientId: dotenv.env['NAVER_MAP_CLIENT_ID'],
      onAuthFailed: (error) {
        print('Auth failed: $error');
      });
  runApp(const MyApp());
  initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: BACK_COLOR,
      statusBarIconBrightness: Brightness.dark,
    ));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
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
