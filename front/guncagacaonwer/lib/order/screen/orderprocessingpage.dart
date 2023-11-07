import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:guncagacaonwer/order/models/orderlistmodel.dart';
import 'package:intl/intl.dart';

import '../api/processingpage_api_service.dart';

class OrderProcessingPage extends StatefulWidget {
  @override
  _OrderProcessingPageState createState() => _OrderProcessingPageState();
}

class _OrderProcessingPageState extends State<OrderProcessingPage> {

  bool isSelected = false;

  List<Order> orders = [];
  late ApiService apiService;

  @override
  void initState() {
    super.initState();

    Dio dio = Dio();
    dio.interceptors.add(LogInterceptor(responseBody: true));
    apiService = ApiService(dio);
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      final token = "";
      final ownerResponse = await apiService.getOwnerInfo(token);
      int storeId = ownerResponse.store_id;
      List<Order> orderList = await apiService.getProcessingList(storeId, "2");
      setState(() {
        orders = orderList;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardDeviceWidth = 500;
    final standardDeviceHeight = 350;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (BuildContext context, int index) {
                final order = orders[index];
                int totalQuantity = order.menus.map((menu) => menu.quantity).reduce((a, b) => a + b);
                final formatter = NumberFormat('#,###');
                String formattedTotalPrice = formatter.format(order.price);

                List<String> orderTimeParts = order.orderTime.split(" ");
                String timeOfDay = "";
                String time = orderTimeParts[1];

                int hour = int.parse(time.split(":")[0]);
                if (hour >= 12) {
                  if (hour > 12) {
                    hour -= 12;
                  }
                  timeOfDay = "오후";
                } else {
                  timeOfDay = "오전";
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 1),
                  child: Container(
                    alignment: Alignment.center,
                    width: 70 * (deviceWidth / standardDeviceWidth),
                    height: 65 * (deviceHeight / standardDeviceHeight),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xFFE6E6E6),
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 60 * (deviceWidth / standardDeviceWidth),
                          margin: EdgeInsets.only(
                              top: 7 * (deviceHeight / standardDeviceHeight),
                              left: 7 * (deviceWidth / standardDeviceWidth)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '주문 시간',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9 * (deviceWidth / standardDeviceWidth),
                                ),
                              ),
                              SizedBox(height: 2 * (deviceHeight / standardDeviceHeight)),
                              Text(
                                timeOfDay,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9 * (deviceWidth / standardDeviceWidth),
                                ),
                              ),
                              SizedBox(height: 2 * (deviceHeight / standardDeviceHeight)),
                              Text(
                                '$hour:${time.split(":")[1]}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13 * (deviceWidth / standardDeviceWidth),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 13 * (deviceWidth / standardDeviceWidth),
                        ),
                        Container(
                          width: 160 * (deviceWidth / standardDeviceWidth),
                          margin: EdgeInsets.only(top: 3 * (deviceHeight / standardDeviceHeight)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 4 * (deviceHeight / standardDeviceHeight),
                              ),
                              Text(
                                '메뉴 [$totalQuantity]개 / '+formattedTotalPrice+"원",
                                style: TextStyle(
                                  fontSize: 8 * (deviceWidth / standardDeviceWidth),
                                ),
                              ),
                              SizedBox(
                                height: 6 * (deviceHeight / standardDeviceHeight),
                              ),
                              Text(
                                '주문자 번호 : ${order.memberId}',
                                style: TextStyle(
                                  fontSize: 8 * (deviceWidth / standardDeviceWidth),
                                  color: Color(0xFF9B5748),
                                ),
                              ),
                              SizedBox(
                                height: 6 * (deviceHeight / standardDeviceHeight),
                              ),
                              Text(
                                "도착 예정 시간: " +
                                    timeOfDay +
                                    ' $hour:${time.split(":")[1]}',
                                style: TextStyle(
                                  fontSize: 8 * (deviceWidth / standardDeviceWidth),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 38 * (deviceWidth / standardDeviceWidth),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 40 * (deviceWidth / standardDeviceWidth),
                                height: 60 * (deviceHeight / standardDeviceHeight),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (!isSelected) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                            content: Container(
                                              width: 200 * (deviceWidth / standardDeviceWidth),
                                              height: 280 * (deviceHeight / standardDeviceHeight),
                                              child: SingleChildScrollView( // 스크롤 가능한 영역 추가
                                                child: Column(
                                                  children: [
                                                    // 모달 다이얼로그 내용
                                                    Text('$totalQuantity')
                                                    // 만약 내용이 모달 높이보다 크면 스크롤이 활성화됩니다.
                                                  ],
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              // 모달 다이얼로그 액션 버튼 등을 추가할 수 있습니다.
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      // isSelected가 false일 때의 동작 추가
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Color(0xFFACACAC),
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    '주문표\n 인쇄',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 8 * (deviceWidth / standardDeviceWidth),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 2 * (deviceWidth / standardDeviceWidth),
                              ),
                              Container(
                                width: 40 * (deviceWidth / standardDeviceWidth),
                                height: 60 * (deviceHeight / standardDeviceHeight),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {
                                        // 버튼 동작을 여기에 추가
                                        setState(() {
                                          if (!order.inProgress) {
                                            order.inProgress = true;
                                          }
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: order.inProgress
                                            ? Colors.orange
                                            : Colors.grey,
                                        minimumSize: Size(
                                          40 * (deviceWidth / standardDeviceWidth),
                                          60 * (deviceHeight / standardDeviceHeight),
                                        ),
                                      ),
                                      child: Text(
                                        order.inProgress
                                            ? '준비중'
                                            : '제작\n대기',
                                        style: TextStyle(
                                          color: order.inProgress
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 8 * (deviceWidth / standardDeviceWidth),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 2 * (deviceWidth / standardDeviceWidth),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 40 * (deviceWidth / standardDeviceWidth),
                                            height: 60 * (deviceHeight / standardDeviceHeight),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (!order.inProgress) {
                                                    // "제작" 버튼이 눌렸을 때의 기능 추가
                                                    // 예: 어떤 작업을 실행하거나 상태 변경
                                                    order.inProgress = true;
                                                    isSelected = true; // isSelected를 true로 설정
                                                  } else {
                                                    // "완료" 버튼이 눌렸을 때의 기능 추가
                                                    // 모달 다이얼로그 구현
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                                          content: Container(
                                                            width: 200 * (deviceWidth / standardDeviceWidth),
                                                            height: 280 * (deviceHeight / standardDeviceHeight),
                                                            child: SingleChildScrollView(
                                                              child: Column(
                                                                children: [
                                                                  Text('주문 정보:'),
                                                                  Text('주문 시간: ${order.orderTime}'),
                                                                  Text('메뉴 수량: $totalQuantity'),
                                                                  // 다른 주문 정보 출력...
                                                                  if (order.inProgress)
                                                                    TextButton(
                                                                      onPressed: () {
                                                                        // FCM를 사용하여 알림 보내기 (FCM 관련 코드 필요)
                                                                        // sendNotification(order);
                                                                      },
                                                                      child: Text('알림 보내기'),
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                // 선택 해제
                                                                orders.remove(order); // 해당 항목을 리스트에서 삭제
                                                                setState(() {
                                                                  isSelected = false;
                                                                });
                                                                Navigator.of(context).pop(); // 모달 닫기
                                                              },
                                                              child: Text('확인'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  }
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: order.inProgress
                                                    ? Color(0xFF4449BA)
                                                    : Color(0xFF4449BA),
                                                minimumSize: Size(
                                                  40 * (deviceWidth / standardDeviceWidth),
                                                  60 * (deviceHeight / standardDeviceHeight),
                                                ),
                                              ),
                                              child: Text(
                                                order.inProgress ? '완료' : '제작',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
