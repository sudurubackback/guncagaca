import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'basic/screen/landingpage.dart';

void main() {
  runApp(MyApp());
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

  Future<void> initSSE() async {
    try {
      eventSource = EventSource('https://k9d102.p.ssafy.io/api/order/sse/8');

      // SSE 이벤트 수신 시 처리 로직
      eventSource?.addEventListener('message', (MessageEvent event) {
        var eventData = jsonDecode(event.data);

        // 특정 조건을 만족할 때 토스트 메시지 표시
          print('알림 옴');
          _showOrderToast();
      } as EventListener?);
    } catch (e) {
      print('SSE 초기화 오류: $e');
    }
  }

  void closeSSE() {
    eventSource?.close();
  }

  void _showOrderToast() {
    Get.snackbar(
      '새로운 주문이 도착했습니다!',
      '주문이 접수되었습니다.',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 5),
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}

