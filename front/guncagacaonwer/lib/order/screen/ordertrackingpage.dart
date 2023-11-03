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
  DateTime? startingDate;
  DateTime? endingDate;

  TextEditingController startingDateController = TextEditingController();
  TextEditingController endingDateController = TextEditingController();

  Future<void> _selectDate(BuildContext context, TextEditingController controller, DateTime? selectedDate, bool isStartingDate) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2010, 1, 1),
      lastDate: DateTime.now(),
    ))!;

    if (picked != null && picked != selectedDate) {
      // 사용자가 날짜를 선택한 경우
      if (isStartingDate) {
        // 시작 날짜 선택
        startingDate = picked;
      } else {
        // 종료 날짜 선택
        endingDate = picked;
      }
      // 선택한 날짜를 텍스트 필드에 업데이트
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }
  List<Map<String, dynamic>> filteredOrders = [];

  // 날짜 필터링
  List<Map<String, dynamic>> filterOrdersByDate(
      List<Map<String, dynamic>> orders,
      DateTime? startingDate,
      DateTime? endingDate,
      ) {
    if (startingDate == null || endingDate == null) {
      return orders; // 선택된 날짜 범위가 없으면 모든 주문 반환
    }

    return orders.where((order) {
      DateTime orderTime = DateTime.parse(order['orderTime']);
      return orderTime.isAfter(startingDate) && orderTime.isBefore(endingDate);
    }).toList();
  }

  void applyDateFilter() {
    if (startingDate != null && endingDate != null) {
      setState(() {
        // filteredOrders에 날짜 필터 적용
        filteredOrders = filterOrdersByDate(processingOrders, startingDate, endingDate);
      });
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
          Row(
            children: [
              SizedBox(width: 20 * (deviceWidth / standardDeviceWidth)),
              GestureDetector(
                onTap: () {
                  _selectDate(context, startingDateController, startingDate, true);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                  ),
                  width: 60 * (deviceWidth / standardDeviceWidth),
                  child: Center(
                    child: TextFormField(
                      enabled: false,
                      controller: startingDateController,
                      decoration: InputDecoration(
                        hintText: startingDate != null ? DateFormat('yyyy-MM-dd').format(startingDate!) : '시작일 선택',
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 9 * (deviceWidth / standardDeviceWidth),
                      ),
                    ),
                  ),
                ),
              ),
              Text(' ~ ', style: TextStyle(fontSize: 12 * (deviceWidth / standardDeviceWidth))),
              GestureDetector(
                onTap: () {
                  _selectDate(context, endingDateController, endingDate, false);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                  ),
                  width: 60 * (deviceWidth / standardDeviceWidth),
                  child: Center(
                    child: TextFormField(
                      enabled: false,
                      controller: endingDateController,
                      decoration: InputDecoration(
                        hintText: endingDate != null ? DateFormat('yyyy-MM-dd').format(endingDate!) : '종료일 선택',
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 9 * (deviceWidth / standardDeviceWidth),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(), // 화면에서 남은 공간을 차지
              ElevatedButton(
                onPressed: applyDateFilter,
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFE54816), // 버튼의 배경색
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Color(0xFFACACAC), // 외곽선 색상
                      width: 1.0, // 외곽선 두께
                    ),
                  ),
                ),
                child: Text(
                  '적용',
                  style: TextStyle(
                    color: Colors.white, // 버튼 텍스트 색상
                    fontSize: 12 * (deviceWidth / standardDeviceWidth), // 버튼 텍스트 크기
                  ),
                ),
              ),
              SizedBox(width: 10 * (deviceWidth / standardDeviceWidth))
            ],
          ),
          SizedBox(height: 3 * (deviceHeight / standardDeviceHeight)),
          Expanded(
            child: ListView.builder(
              itemCount: filteredOrders.length,
              itemBuilder: (BuildContext context, int index) {
                final order = filteredOrders[index];
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
                                '메뉴 [${order["totalMenuCount"]}]개 / '+formattedTotalPrice+"원",
                                style: TextStyle(
                                  fontSize: 8 * (deviceWidth / standardDeviceWidth),
                                ),
                              ),
                              SizedBox(
                                height: 6 * (deviceHeight / standardDeviceHeight),
                              ),
                              Text(
                                '닉네임 : ${order['nickname']}',
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
                                                  Text('주문 시간: ${order["orderTime"]}'),
                                                  Text('메뉴 수량: ${order["totalMenuCount"]}'),
                                                  Text('총 가격: ${formattedTotalPrice}원'),
                                                  Text('메뉴 목록:'),
                                                  for (String menu in order["menuList"])
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
