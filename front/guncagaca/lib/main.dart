import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:guncagaca/common/const/colors.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:guncagaca/login/landingpage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../common/utils/oauth_token_manager.dart' as KakaoTokenManager;

import 'cart/controller/cart_controller.dart';


Future<void> requestMultiplePermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.camera,
  ].request();

  // 각 권한에 대한 상태 확인
  if (statuses[Permission.location]?.isGranted ?? false) {
    // 위치 권한 허용됨
  }
  if (statuses[Permission.notification]?.isGranted ?? false) {
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // .env 파일 Path

  // 위치 권한 및 알림 권한 요청
  await requestMultiplePermissions();

  KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_SDK_NATIVE_KEY']);
  await KakaoTokenManager.TokenManager().initialize();
  await NaverMapSdk.instance.initialize(
      clientId: dotenv.env['NAVER_MAP_CLIENT_ID'],
      onAuthFailed: (error) {
        print('Auth failed: $error');
      });

  runApp(const MyApp());
  initializeDateFormatting();
  // await KakaoTokenManager.TokenManager().refreshToken();
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
