import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class OrderProcessingPage extends StatefulWidget {
  @override
  _OrderProcessingPageState createState() => _OrderProcessingPageState();
}

class _OrderProcessingPageState extends State<OrderProcessingPage> {
  List<OrderItem> processingOrders = [];

  List<OrderItem> convertToOrderItems(List<Map<String, dynamic>> data) {
    List<OrderItem> orderItems = [];
    for (var itemData in data) {
      OrderItem orderItem = OrderItem(
        orderTime: itemData["orderTime"],
        totalMenuCount: itemData["totalMenuCount"],
        totalPrice: itemData["totalPrice"],
        menuList: List<String>.from(itemData["menuList"]),
        nickname: itemData["nickname"],
        arrivalTime: itemData["arrivalTime"],
      );
      orderItems.add(orderItem);
    }
    return orderItems;
  }

  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    // 가상 데이터를 사용하여 OrderItem 객체를 생성합니다.
    List<Map<String, dynamic>> virtualData = [
      {
        "orderTime": "2023-10-27 12:30",
        "totalMenuCount": 3,
        "totalPrice": 15000,
        "menuList": ["아메리카노 x 1", "카페라떼 x 2"],
        "nickname": "민승",
        "arrivalTime": "2023-10-27 13:15",
      },
      {
        "orderTime": "2023-10-27 13:00",
        "totalMenuCount": 2,
        "totalPrice": 9000,
        "menuList": ["카페모카 x 2"],
        "nickname": "민승",
        "arrivalTime": "2023-10-27 13:45",
      },
      {
        "orderTime": "2023-10-27 14:15",
        "totalMenuCount": 1,
        "totalPrice": 4500,
        "menuList": ["카페라떼 x 1"],
        "nickname": "민승",
        "arrivalTime": "2023-10-27 15:00",
      },
    ];

    // "List<Map<String, dynamic>>" 데이터를 "List<OrderItem>"으로 변환
    processingOrders = convertToOrderItems(virtualData);
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
              itemCount: processingOrders.length,
              itemBuilder: (BuildContext context, int index) {
                final OrderItem processingOrder = processingOrders[index];

                final formatter = NumberFormat('#,###');
                String formattedTotalPrice = formatter.format(processingOrder.totalPrice);

                List<String> orderTimeParts = processingOrder.orderTime.split(" ");
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
                                '메뉴 [${processingOrder.totalMenuCount}]개 / ' +
                                    formattedTotalPrice + "원",
                                style: TextStyle(
                                  fontSize: 8 * (deviceWidth / standardDeviceWidth),
                                ),
                              ),
                              SizedBox(
                                height: 6 * (deviceHeight / standardDeviceHeight),
                              ),
                              Text(
                                '닉네임 : ${processingOrder.nickname}',
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
                                                    Text('${processingOrder.totalMenuCount}')
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
                                          if (!processingOrder.inProgress) {
                                            processingOrder.inProgress = true;
                                          }
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: processingOrder.inProgress
                                            ? Colors.orange
                                            : Colors.grey,
                                        minimumSize: Size(
                                          40 * (deviceWidth / standardDeviceWidth),
                                          60 * (deviceHeight / standardDeviceHeight),
                                        ),
                                      ),
                                      child: Text(
                                        processingOrder.inProgress
                                            ? '준비중'
                                            : '제작\n대기',
                                        style: TextStyle(
                                          color: processingOrder.inProgress
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
                                                  if (!processingOrder.inProgress) {
                                                    // "제작" 버튼이 눌렸을 때의 기능 추가
                                                    // 예: 어떤 작업을 실행하거나 상태 변경
                                                    processingOrder.inProgress = true;
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
                                                                  Text('주문 시간: ${processingOrder.orderTime}'),
                                                                  Text('메뉴 수량: ${processingOrder.totalMenuCount}'),
                                                                  // 다른 주문 정보 출력...
                                                                  if (processingOrder.inProgress)
                                                                    TextButton(
                                                                      onPressed: () {
                                                                        // FCM를 사용하여 알림 보내기 (FCM 관련 코드 필요)
                                                                        // sendNotification(processingOrder);
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
                                                                processingOrders.remove(processingOrder); // 해당 항목을 리스트에서 삭제
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
                                                primary: processingOrder.inProgress
                                                    ? Color(0xFF4449BA)
                                                    : Color(0xFF4449BA),
                                                minimumSize: Size(
                                                  40 * (deviceWidth / standardDeviceWidth),
                                                  60 * (deviceHeight / standardDeviceHeight),
                                                ),
                                              ),
                                              child: Text(
                                                processingOrder.inProgress ? '완료' : '제작',
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

class OrderItem {
  String orderTime;
  int totalMenuCount;
  int totalPrice;
  List<String> menuList;
  String nickname;
  String arrivalTime;
  bool inProgress = false;

  OrderItem({
    required this.orderTime,
    required this.totalMenuCount,
    required this.totalPrice,
    required this.menuList,
    required this.nickname,
    required this.arrivalTime,
  });
}
