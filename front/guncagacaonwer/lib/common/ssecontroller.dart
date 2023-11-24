import 'dart:async';
import 'dart:html';
import 'dart:html' as html;
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
  // EventSource? eventSource;
  late ApiService apiService;
  late int storeId;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final html.EventSource eventSource;
  final StreamController<String> streamController;

  SSEController._internal(this.eventSource, this.streamController) {
    // 이벤트 리스너 설정
    eventSource.addEventListener('message', (html.Event message) {
      final eventData = (message as html.MessageEvent).data as String;
      streamController.add(eventData);
      // 알림 권한 요청
      window.navigator.permissions?.query({"name": "notifications"}).then((result) {
        if (result.state == "granted") {
          // 권한이 허용된 경우
          onMessageReceived(eventData);
        } else if (result.state == "prompt") {
          // 권한 요청
          html.Notification.requestPermission().then((permission) {
            if (permission == "granted") {
              onMessageReceived(eventData);
            }
          });
        }
      });
    });

    eventSource.onError.listen((event) {
      closeSSE();
    });
  }

  void onMessageReceived(String eventData) {
    // 이벤트 데이터 처리
    showWebNotification();
  }
  // Future<void> setupApiService() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? accessToken = prefs.getString('accessToken');
  //   String? email = prefs.getString('email');
  //   print("email : $email");
  //   Dio dio = Dio();
  //   dio.interceptors.add(AuthInterceptor(accessToken));
  //   dio.interceptors.add(LogInterceptor(responseBody: true));
  //   apiService = ApiService(dio);
  //
  //   // storeId 초기화
  //   final ownerResponse = await apiService.getOwnerInfo();
  //   storeId = ownerResponse.storeId ?? 0;
  // }

  factory SSEController.connect({
    bool withCredentials = false,
    bool closeOnError = true,
  }) {
    final streamController = StreamController<String>();
    final eventSource = html.EventSource('http://k9d102.p.ssafy.io:8083/api/order/sse/8', withCredentials: withCredentials);

    return SSEController._internal(eventSource, streamController);
  }

  Stream get stream => streamController.stream;

  bool isClosed() => streamController.isClosed;


  // Future<void> initSSE() async {
  //   try {
  //     await setupApiService();
  //     print("스토어아이디 $storeId");
  //     eventSource = EventSource('http://k9d102.p.ssafy.io:8083/api/order/sse/$storeId');
  //
  //     // SSE 이벤트 수신 시 처리 로직
  //     eventSource?.addEventListener('message', (Event event) async {
  //       var eventData = jsonDecode((event as MessageEvent).data);
  //       print("eventData: $eventData");
  //       showWebNotification("주문 도착!","새로운 주문이 도착했어요.");
  //     } as EventListener?);
  //   } catch (e) {
  //     print('SSE 초기화 오류: $e');
  //   }
  // }

  // Future<void> initSSE() async {
  //   await setupApiService();
  //   print("sse 가게 $storeId");
  //   final prefs = await SharedPreferences.getInstance();
  //   String? accessToken = prefs.getString('accessToken');
  //
  //   _connectToSSE(storeId, accessToken);
  // }
  //
  // void _connectToSSE(int? storeId, String? accessToken) {
  //   try {
  //     SSEClient.subscribeToSSE(
  //       method: SSERequestType.GET,
  //       url: 'http://k9d102.p.ssafy.io:8083/api/order/sse/$storeId',
  //       header: {
  //         "Authorization": "Bearer $accessToken",
  //         "Accept": "text/event-stream",
  //         "Cache-Control": "no-cache",
  //       },
  //     ).listen(
  //           (event) {
  //         // 이벤트 처리
  //         print('Id: ' + event.id!);
  //         print('Event: ' + event.event!);
  //         print('Data: ' + event.data!);
  //         var eventData = jsonDecode((event as MessageEvent).data);
  //         print("eventData: $eventData");
  //         showWebNotification("주문 도착!","새로운 주문이 도착했어요.");
  //       },
  //       onDone: () {
  //         // 연결이 종료될 때 재연결 시도
  //         print("SSE 연결 종료됨. 재연결 시도.");
  //         _connectToSSE(storeId, accessToken);
  //       },
  //       onError: (error) {
  //         // 오류 발생 시 재연결 시도
  //         print("SSE 연결 오류: $error. 재연결 시도.");
  //         _connectToSSE(storeId, accessToken);
  //       },
  //     );
  //   } catch (e) {
  //     print('SSE 초기화 오류: $e');
  //   }
  // }


  void closeSSE() {
    eventSource.close();
    streamController.close();
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
            'assets/barista.png',
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

  Future<void> showWebNotification() async {
    print("소리 출력");
    _audioPlayer.setAsset('assets/sound/sound1.mp3');
    _audioPlayer.play();

    print("백그라운드 메시지");
    if (html.Notification.supported) {
      // 알림 권한 요청
     await html.Notification.requestPermission();


        // 사용자가 알림 권한을 허용한 경우에만 알림 생성
        html.Notification("주문", body: "주문이 들어왔습니다 !", icon: 'web/icons/assets/guncagaca-icon.png');
        // 특정 조건을 만족할 때 다이얼로그 표시
        print('알림 옴');
        _showOrderDialog();

    } else {
      print('브라우저가 알림을 지원하지 않습니다.');
    }
  }

}
