import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderWaitingPage extends StatefulWidget {

  @override
  _OrderWaitingPageState createState() => _OrderWaitingPageState();
}

class _OrderWaitingPageState extends State<OrderWaitingPage> {

  final List<Map<String, dynamic>> orders = [
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
    // 여기에 다른 가상 주문 데이터를 추가할 수 있습니다.
  ];

  List<Map<String, dynamic>> processingOrders = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                final formatter = NumberFormat('#,###');
                String formattedTotalPrice = formatter.format(order["totalPrice"]);
                // 주문 시간에서 날짜와 시간 추출
                List<String> orderTimeParts = order["orderTime"].split(" ");
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
                          width: 500,
                          margin: EdgeInsets.only(top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '메뉴 [${order["totalMenuCount"]}]개 / '+formattedTotalPrice+"원",
                                style: TextStyle(
                                    fontSize: 18
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                '${order["menuList"].join(" / ")}',
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
                          width: 50,
                        ),
                        // 세번째 컨테이너 (버튼)
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // 접수하기 버튼 클릭 시 수행할 동작 추가
                                  setState(() {
                                    processingOrders.add(order);
                                    orders.removeAt(index);
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF406AD6), // 버튼의 배경색
                                  minimumSize: Size(120,55), // 버튼의 최소 크기
                                ),
                                child: Text(
                                  '접수하기',
                                  style: TextStyle(
                                    color: Colors.white, // 버튼 텍스트 색상
                                    fontSize: 18, // 버튼 텍스트 크기
                                  ),
                                ),
                              ),
                              SizedBox(height: 5), // 버튼 사이의 간격 조절
                              ElevatedButton(
                                onPressed: () {
                                  // 주문 취소 버튼 클릭 시 수행할 동작 추가
                                  setState(() {
                                    orders.removeAt(index);
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFD63737), // 버튼의 배경색
                                  minimumSize: Size(120, 55), // 버튼의 최소 크기
                                ),
                                child: Text(
                                  '주문 취소',
                                  style: TextStyle(
                                    color: Colors.white, // 버튼 텍스트 색상
                                    fontSize: 18, // 버튼 텍스트 크기
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
