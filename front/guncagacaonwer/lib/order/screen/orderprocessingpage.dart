import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderProcessingPage extends StatefulWidget {

  @override
  _OrderProcessingPageState createState() => _OrderProcessingPageState();
}

class _OrderProcessingPageState extends State<OrderProcessingPage> {
  bool inProgress = false; // 상태 변수
  int initialTime = 20; // 초기 시간 (예: 20분)
  int currentTime = 20; // 현재 시간
  double progressValue = 1.0; // 프로그레스 바의 초기 값 (1.0은 100%를 나타냅니다)

  @override
  void initState() {
    super.initState();

    // 1분마다 현재 시간을 감소시키는 타이머 시작
    Timer.periodic(Duration(minutes: 1), (Timer timer) {
      if (currentTime > 0) {
        setState(() {
          currentTime--;
          progressValue = currentTime / initialTime; // 현재 시간에 따라 진행 상태 업데이트
        });
      } else {
        timer.cancel(); // 시간이 다 떨어지면 타이머 중지
        // 타이머가 종료되면 작업 완료 상태로 변경
        setState(() {
          inProgress = false;
        });
      }
    });
  }

  final List<Map<String, dynamic>> processingOrders = [
    {
      "orderTime": "2023-10-27 12:30",
      "totalMenuCount": 3,
      "totalPrice" : 15000,
      "menuList": ["아메리카노 x 1", "카페라떼 x 2"],
      "nickname" : "민승",
      "arrivalTime": "2023-10-27 13:15",
    },
    {
      "orderTime": "2023-10-27 13:00",
      "totalMenuCount": 2,
      "totalPrice" : 9000,
      "menuList": ["카페모카 x 2"],
      "nickname" : "민승",
      "arrivalTime": "2023-10-27 13:45",
    },
    {
      "orderTime": "2023-10-27 14:15",
      "totalMenuCount": 1,
      "totalPrice" : 4500,
      "menuList": ["카페라떼 x 1"],
      "nickname" : "민승",
      "arrivalTime": "2023-10-27 15:00",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: processingOrders.length,
              itemBuilder: (context, index) {
                final processingorder = processingOrders[index];
                final formatter = NumberFormat('#,###');
                String formattedTotalPrice = formatter.format(processingorder["totalPrice"]);
                // 주문 시간에서 날짜와 시간 추출
                List<String> orderTimeParts = processingorder["orderTime"].split(" ");
                String timeOfDay = "";
                String time = orderTimeParts[1];
                // 시간을 오전/오후로 나누기
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
                        // 첫번째 컨테이너 (주문 시간)
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
                        // 두번째 컨테이너 (메뉴 총 개수, 메뉴-개수, 도착 예정 시간)
                        Container(
                          width: 350,
                          margin: EdgeInsets.only(top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '메뉴 [${processingorder["totalMenuCount"]}]개 / '+formattedTotalPrice+"원",
                                style: TextStyle(
                                    fontSize: 18
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                '닉네임 : ${processingorder['nickname']}',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF9B5748)
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "도착 예정 시간: " + timeOfDay + ' $hour:${time.split(":")[1]}',
                                style: TextStyle(
                                    fontSize: 18
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        // 세번째 컨테이너 (버튼)
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, // 컨테이너를 가로로 배치
                            children: [
                              Container(
                                width: 80,
                                height: 110,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // 접수하기 버튼 클릭 시 수행할 동작 추가
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white, // 버튼의 배경색
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Color(0xFFACACAC), // 외곽선 색상
                                        width: 1.0, // 외곽선 두께
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    '주문표'+'\n'+'  인쇄',
                                    style: TextStyle(
                                      color: Colors.black, // 버튼 텍스트 색상
                                      fontSize: 16, // 버튼 텍스트 크기
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 80,
                                height: 110,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // 접수하기 버튼 클릭 시 수행할 동작 추가
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF406AD6), // 버튼의 배경색
                                  ),
                                  child: Text(
                                    '접수하기',
                                    style: TextStyle(
                                      color: Colors.white, // 버튼 텍스트 색상
                                      fontSize: 18, // 버튼 텍스트 크기
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              // 두 번째 컨테이너 (시간 표시 및 프로그레스 바)
                              Container(
                                width: 80,
                                height: 110,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    inProgress
                                        ? Column(
                                      children: [
                                        Text(
                                          '${currentTime}분',
                                          style: TextStyle(
                                            color: Colors.black, // 텍스트 색상
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        LinearProgressIndicator(
                                          value: progressValue, // 진행 상태
                                          backgroundColor: Colors.grey, // 바의 배경색
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // 바의 진행 색상
                                        ),
                                      ],
                                    )
                                        : ElevatedButton(
                                      onPressed: () {
                                        if (!inProgress) {
                                          // 버튼을 눌렀을 때 초기 시간을 설정하고 타이머 시작
                                          setState(() {
                                            currentTime = initialTime;
                                            inProgress = true;
                                            // 타이머 시작
                                            Timer.periodic(Duration(minutes: 1), (Timer timer) {
                                              if (currentTime > 0) {
                                                setState(() {
                                                  currentTime--;
                                                  progressValue = currentTime / initialTime;
                                                });
                                              } else {
                                                timer.cancel();
                                                setState(() {
                                                  inProgress = false;
                                                });
                                              }
                                            });
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: inProgress ? Color(0xFF406AD6) : Color(0xFF406AD6),
                                        minimumSize: Size(80, 110),
                                      ),
                                      child: Text(
                                        inProgress ? '제작' : '제작',
                                        style: TextStyle(
                                          color: inProgress ? Colors.white : Colors.white,
                                          fontSize: 18,
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
