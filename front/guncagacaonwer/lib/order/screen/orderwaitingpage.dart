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
                        // 첫번째 컨테이너 (주문 시간)
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
                        // 두번째 컨테이너 (메뉴 총 개수, 메뉴-개수, 도착 예정 시간)
                        Container(
                          width: 230 * (deviceWidth / standardDeviceWidth),
                          margin: EdgeInsets.only(top: 3 * (deviceHeight / standardDeviceHeight)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 4 * (deviceHeight / standardDeviceHeight),
                              ),
                              Text(
                                '메뉴 [${order["totalMenuCount"]}]개 / '+formattedTotalPrice+"원",
                                style: TextStyle(
                                  fontSize: 8 * (deviceWidth / standardDeviceWidth),
                                ),
                              ),
                              SizedBox(
                                height: 6 * (deviceHeight / standardDeviceHeight),
                              ),
                              Text(
                                '${order["menuList"].join(" / ")}',
                                style: TextStyle(
                                    fontSize: 8 * (deviceWidth / standardDeviceWidth),
                                    color: Color(0xFF9B5748)
                                ),
                              ),
                              SizedBox(
                                height: 6 * (deviceHeight / standardDeviceHeight),
                              ),
                              Text(
                                "도착 예정 시간: " + timeOfDay + ' $hour:${time.split(":")[1]}',
                                style: TextStyle(
                                  fontSize: 8 * (deviceWidth / standardDeviceWidth),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 24 * (deviceWidth / standardDeviceWidth),
                        ),
                        // 세번째 컨테이너 (버튼)
                        Container(
                          child : Align(
                            alignment: Alignment.centerRight,
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
                                    minimumSize: Size(
                                        60 * (deviceWidth / standardDeviceWidth),
                                        28 * (deviceHeight / standardDeviceHeight)), // 버튼의 최소 크기
                                  ),
                                  child: Text(
                                    '접수하기',
                                    style: TextStyle(
                                      color: Colors.white, // 버튼 텍스트 색상
                                      fontSize: 10 * (deviceWidth / standardDeviceWidth), // 버튼 텍스트 크기
                                    ),
                                  ),
                                ),
                                SizedBox(height: 1 * (deviceHeight / standardDeviceHeight)), // 버튼 사이의 간격 조절
                                ElevatedButton(
                                  onPressed: () {
                                    // 주문 취소 버튼 클릭 시 수행할 동작 추가
                                    setState(() {
                                      orders.removeAt(index);
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFD63737), // 버튼의 배경색
                                    minimumSize: Size(
                                      60 * (deviceWidth / standardDeviceWidth),
                                      28 * (deviceHeight / standardDeviceHeight)), // 버튼의 최소 크기
                                  ),
                                  child: Text(
                                    '주문 취소',
                                    style: TextStyle(
                                      color: Colors.white, // 버튼 텍스트 색상
                                      fontSize: 10 * (deviceWidth / standardDeviceWidth), // 버튼 텍스트 크기
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
