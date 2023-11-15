import 'dart:convert';
import 'dart:html';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared\_preferences/shared\_preferences.dart';
import 'package:get/get.dart';
import 'package:guncagacaonwer/common/const/colors.dart';
import 'package:just_audio/just_audio.dart';
import 'basic/screen/landingpage.dart';
import 'menu/api/menuallpage_api_service.dart';
import 'order/screen/orderpage.dart';
import 'order/screen/orderwaitingpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  // SSE 초기화
  SSEController sseController = SSEController();
  await sseController.setupApiService();
  await sseController.initSSE();
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

class SSEController {
  EventSource? eventSource;
  late ApiService apiService;
  late int storeId;
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> setupApiService() async {
    final prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    String? email = prefs.getString('email');
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor(accessToken));
    dio.interceptors.add(LogInterceptor(responseBody: true));
    apiService = ApiService(dio);

    // storeId 초기화
    final ownerResponse = await apiService.getOwnerInfo();
    storeId = ownerResponse.storeId ?? 0;
  }

  Future<void> initSSE() async {
    try {
      await setupApiService();
      print("스토어아이디");
      print(storeId);
      eventSource = EventSource('http://k9d102.p.ssafy.io:8083/api/order/sse/$storeId');

      // SSE 이벤트 수신 시 처리 로직
      eventSource?.addEventListener('message', (Event event) async {
        var eventData = jsonDecode((event as MessageEvent).data);

        // 특정 조건을 만족할 때 다이얼로그 표시
        print('알림 옴');
        // 소리 재생
        _showOrderDialog();
        await _audioPlayer.setAsset('assets/sound/sound1.mp3'); // 소리 파일 경로에 맞게 수정
        await _audioPlayer.play();
      } as EventListener?);
    } catch (e) {
      print('SSE 초기화 오류: $e');
    }
  }

  void closeSSE() {
    eventSource?.close();
  }

  void _showOrderDialog() {
    Get.defaultDialog(
      title: '주문 도착!',
      titleStyle: TextStyle(color: Colors.black, fontSize: 28), // 타이틀 폰트 크기 조절
      titlePadding: EdgeInsets.all(20), // 타이틀 여백 조절
      backgroundColor: BACK_COLOR,
      contentPadding: EdgeInsets.all(20),
      content: Column(
        children: [
          Image.asset(
            'assets/coffees.png',
            height: 150,
            width: 150,
          ),
          SizedBox(height: 20),
          Text(
            '새로운 주문이 도착했어요.',
            style: TextStyle(color: Colors.black, fontSize: 28),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Get.off(OrderPage());
          },
          style: ElevatedButton.styleFrom(
            primary: PRIMARY_COLOR,
            fixedSize: Size(200, 50), // 버튼의 크기 조절
          ),
          child: Text(
            '확인',
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          style: ElevatedButton.styleFrom(
            primary: PRIMARY_COLOR,
            fixedSize: Size(200, 50), // 버튼의 크기 조절
          ),
          child: Text(
            '취소',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

}
