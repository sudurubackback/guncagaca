import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class OrderCompletePage extends StatefulWidget {

  @override
  _OrderCompletePageState createState() => _OrderCompletePageState();
}

class _OrderCompletePageState extends State<OrderCompletePage> {

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
                                '메뉴 [${processingorder["totalMenuCount"]}]개 / '+formattedTotalPrice+"원",
                                style: TextStyle(
                                  fontSize: 8 * (deviceWidth / standardDeviceWidth),
                                ),
                              ),
                              SizedBox(
                                height: 6 * (deviceHeight / standardDeviceHeight),
                              ),
                              Text(
                                '닉네임 : ${processingorder['nickname']}',
                                style: TextStyle(
                                  fontSize: 8 * (deviceWidth / standardDeviceWidth),
                                  color: Color(0xFF9B5748),
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
                          width: 80 * (deviceWidth / standardDeviceWidth),
                        ),
                        // 세번째 컨테이너 (버튼)
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, // 컨테이너를 가로로 배치
                            children: [
                              Container(
                                width: 80 * (deviceWidth / standardDeviceWidth),
                                height: 110 * (deviceHeight / standardDeviceHeight),
                                child: ElevatedButton(
                                  onPressed: () {
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
                                                  Text('주문 정보:'),
                                                  Text('주문 시간: ${processingorder["orderTime"]}'),
                                                  Text('메뉴 수량: ${processingorder["totalMenuCount"]}'),
                                                  Text('총 가격: ${formattedTotalPrice}원'),
                                                  Text('메뉴 목록:'),
                                                  for (String menu in processingorder["menuList"])
                                                    Text(menu),
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
                                      fontSize: 12 * (deviceWidth / standardDeviceWidth), // 버튼 텍스트 크기
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
