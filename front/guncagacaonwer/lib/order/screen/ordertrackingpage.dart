import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderTrackingPage extends StatefulWidget {

  @override
  _OrderTrackingPageState createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
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
              itemBuilder: (BuildContext context, int index) {
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
                          width: 150,
                        ),
                        // 세번째 컨테이너 (버튼)
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, // 컨테이너를 가로로 배치
                            children: [
                              Container(
                                width: 140,
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
                                    primary: Color(0xFFCA1858), // 버튼의 배경색
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Color(0xFFACACAC), // 외곽선 색상
                                        width: 1.0, // 외곽선 두께
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    '주문표'+'\n'+'  확인',
                                    style: TextStyle(
                                      color: Colors.white, // 버튼 텍스트 색상
                                      fontSize: 24, // 버튼 텍스트 크기
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
