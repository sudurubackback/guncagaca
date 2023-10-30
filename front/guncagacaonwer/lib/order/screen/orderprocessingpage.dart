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
        currentTime: 20,
      );
      orderItems.add(orderItem);
    }
    return orderItems;
  }

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

    // 각 OrderItem 객체마다 개별 타이머를 생성
    for (var order in processingOrders) {
      order.startTimer();
    }
  }

  // 모달 창을 열어주는 함수
  void _showModal(OrderItem order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('주문 완료'),
          content: Text('주문이 완료되었습니다.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // "닫기" 버튼을 누를 때 해당 항목을 리스트에서 제거하고 화면을 업데이트
                setState(() {
                  processingOrders.remove(order);
                });
                Navigator.of(context).pop();
              },
              child: Text('닫기'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
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
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  child: Container(
                    alignment: Alignment.center,
                    width: 150,
                    height: 130,
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
                          width: 150,
                          margin: EdgeInsets.only(top: 15, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '주문 시간',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                timeOfDay,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '$hour:${time.split(":")[1]}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 36,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: 350,
                          margin: EdgeInsets.only(top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '메뉴 [${processingOrder.totalMenuCount}]개 / ' +
                                    formattedTotalPrice +
                                    "원",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                '닉네임 : ${processingOrder.nickname}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF9B5748),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "도착 예정 시간: " +
                                    timeOfDay +
                                    ' $hour:${time.split(":")[1]}',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 90,
                                height: 110,
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                          content: Container(
                                            width: 400,
                                            height: 600,
                                            child: SingleChildScrollView( // 스크롤 가능한 영역 추가
                                              child: Column(
                                                children: [
                                                  // 모달 다이얼로그 내용
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
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: 90,
                                height: 110,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {
                                        // 버튼 동작을 여기에 추가
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: processingOrder.inProgress
                                            ? (processingOrder.currentTime > 0
                                            ? Colors.orange
                                            : Colors.green)
                                            : Colors.grey,
                                        minimumSize: Size(90, 110),
                                      ),
                                      child: Text(
                                        processingOrder.inProgress
                                            ? (processingOrder.currentTime > 0
                                            ? '준비중'
                                            : '완료')
                                            : '제작\n대기',
                                        style: TextStyle(
                                          color: processingOrder.inProgress
                                              ? (processingOrder.currentTime > 0
                                              ? Colors.white
                                              : Colors.white)
                                              : Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: 90,
                                height: 110,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    processingOrder.inProgress
                                        ? Column(
                                      children: [
                                        StreamBuilder<int>(
                                          stream: processingOrder.timerStream,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              int remainingTime = snapshot.data!;
                                              int minutes = remainingTime ~/ 60;
                                              int seconds = remainingTime % 60;
                                              return Text(
                                                '$minutes:${seconds.toString().padLeft(2, '0')}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 22,
                                                ),
                                              );
                                            } else {
                                              return Text('00:00', style: TextStyle(color: Colors.black, fontSize: 18));
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    )
                                        : ElevatedButton(
                                      onPressed: () {
                                        if (!processingOrder.inProgress) {
                                          setState(() {
                                            processingOrder.currentTime = processingOrder.initialTime;
                                            processingOrder.inProgress = true;
                                            processingOrder.startTimer();
                                          });

                                          // 타이머가 다 지날 때 모달 창을 열도록 호출
                                          Future.delayed(Duration(seconds: processingOrder.initialTime), () {
                                            _showModal(processingOrder); // 모달 창을 열어줄 함수 호출
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: processingOrder.inProgress
                                            ? Color(0xFF406AD6)
                                            : Color(0xFF406AD6),
                                        minimumSize: Size(90, 110),
                                      ),
                                      child: Text(
                                        processingOrder.inProgress ? '제작' : '제작',
                                        style: TextStyle(color: Colors.white, fontSize: 18),
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
  int initialTime = 60;
  int currentTime;
  double progressValue = 1.0;

  StreamController<int> _timerController = StreamController<int>.broadcast();
  Stream<int> get timerStream => _timerController.stream;

  OrderItem({
    required this.orderTime,
    required this.totalMenuCount,
    required this.totalPrice,
    required this.menuList,
    required this.nickname,
    required this.arrivalTime,
    required this.currentTime,
  });

  void initializeTimer() {
    _timerController = StreamController<int>();
  }

  bool get isCompleted => !inProgress && currentTime == 0;

  void startTimer() {
    const oneSecond = Duration(seconds: 1);

    Timer.periodic(oneSecond, (timer) {
      if (currentTime > 0) {
        currentTime--;
        progressValue = currentTime / initialTime;
        _timerController.sink.add(currentTime); // 타이머 값을 스트림을 통해 전달
      } else {
        inProgress = false;
        _timerController.sink.add(currentTime); // 타이머 값을 스트림을 통해 전달
        timer.cancel();
      }
    });
  }

  void dispose() {
    _timerController.close();
  }
}