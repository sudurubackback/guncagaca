import 'dart:convert';
import 'dart:html';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guncagacaonwer/common/const/colors.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:js' as js;

import '../menu/api/menuallpage_api_service.dart';
import '../order/screen/orderpage.dart';


class SSEController {
  EventSource? eventSource;
  late ApiService apiService;
  late int storeId;
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> setupApiService() async {
    final prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    String? email = prefs.getString('email');
    print("email : $email");
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
        print("eventData: $eventData");
        showWebNotification("주문 도착!","새로운 주문이 도착했어요.");

        // 특정 조건을 만족할 때 다이얼로그 표시
        print('알림 옴');
        _showOrderDialog();
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
      titleStyle: TextStyle(color: Colors.black, fontSize: 28),
      titlePadding: EdgeInsets.all(20),
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
            fixedSize: Size(200, 50),
          ),
          child: Text(
            '확인',
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (Get.currentRoute != 'OrderPage') {
              print(Get.currentRoute);
              print("order페이지가 아님");
              Get.back();
            } else {
              Get.off(OrderPage());
              print("order페이지입니다.");
            }
          },
          style: ElevatedButton.styleFrom(
            primary: PRIMARY_COLOR,
            fixedSize: Size(200, 50),
          ),
          child: Text(
            '취소',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Future<void> showWebNotification(String title, String body) async {
    print("소리 출력");
    _audioPlayer.setAsset('assets/sound/knock.mp3');
    _audioPlayer.play();

    print("백그라운드 메시지");
    js.context.callMethod('showNotification', [title, js.JsObject.jsify({'body': body})]);
  }
}
