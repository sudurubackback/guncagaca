import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guncagacaonwer/order/api/trackingpage_api_service.dart';
import 'package:guncagacaonwer/order/models/orderlistmodel.dart';
import 'package:shared\_preferences/shared\_preferences.dart';
import 'package:intl/intl.dart';

import '../../common/const/colors.dart';
import '../../common/dioclient.dart';

class OrderTrackingPage extends StatefulWidget {

  @override
  _OrderTrackingPageState createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {

  DateTime? startingDate;
  DateTime? endingDate;

  TextEditingController startingDateController = TextEditingController();
  TextEditingController endingDateController = TextEditingController();

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller, DateTime? selectedDate, bool isStartingDate) async {
    DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2010, 1, 1),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: PRIMARY_COLOR,
              onPrimary: Colors.white,
            ),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
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

      // Set time to midnight for both starting and ending dates
      picked = DateTime(
        picked.year,
        picked.month,
        picked.day,
      );

      // 선택한 날짜를 텍스트 필드에 업데이트
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }
  List<Map<String, dynamic>> orders = []; // ordersData 리스트 선언
  late ApiService apiService;



  Future<void> setupApiService() async {
    final prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor(accessToken));
    dio.interceptors.add(LogInterceptor(responseBody: true));
    apiService = ApiService(dio);
  }

  @override
  void initState() {
    super.initState();

    setupApiService();
  }

  void applyDateFilter() {
    // 사용자가 입력한 시작 날짜와 종료 날짜를 가져옵니다.
    DateTime? startDate = startingDate;
    DateTime? endDate = endingDate;

    print("날짜");


    // 날짜가 없을 경우 토스트 메시지를 표시하고 함수 종료
    if (startDate == null || endDate == null) {
      showToast("날짜가 입력되지 않았습니다.");
      return;
    }

    // endDate에 하루를 추가
    // endDate = endDate.add(Duration(days: 1));

    print(startDate.toString());
    print(endDate.toString());

    // 가져온 날짜로 주문을 조회합니다.
    fetchOrders(startDate!, endDate!);
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  String baseUrl = 'https://k9d102.p.ssafy.io';
  Dio dio = DioClient.getInstance();

  Future<void> fetchOrders(DateTime startDate, DateTime endDate) async {


    try {
      final ownerResponse = await apiService.getOwnerInfo();
      print("완료");
      print(ownerResponse.email);
      int storeId = ownerResponse.storeId;
      print(storeId);
      endDate=endDate.add(Duration(days: 1));
      endDate = endDate.add(Duration(hours: 9));
      startDate = startDate.add(Duration(hours: 9));

      final prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      if (storeId != null) {
        final response = await dio.get(
          "$baseUrl/api/order/list/$storeId",
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken',}, // 헤더에 이메일 추가
          ),
          queryParameters: {
            'startDate': startDate.toUtc().toIso8601String(), // UTC 시간으로 변환하여 ISO 8601 형식으로 전송
            'endDate': endDate.toUtc().toIso8601String(),
          },
        );

        if (response.statusCode == 200) {
          // API 응답이 Map 형식인지 확인
          if (response.data is Map<String, dynamic>) {
            Map<String, dynamic> jsonData = response.data;
            // 'data' 키에 해당하는 주문 목록을 가져옵니다.
            orders = List<Map<String, dynamic>>.from(jsonData['data']);
            print(orders);
            print(startDate);
            print(endDate);

            if (orders.isEmpty) {
              showToast("데이터가 없습니다.");
            }

            setState(() {});
            print("api 호출 화면이 새로 고쳐집니다.");
          } else {
            print('API 응답 형식이 예상과 다릅니다: $response.data');
          }
        } else {
          print('데이터 로드 실패, 상태 코드: ${response.statusCode}');
        }
      }
    } catch (e) {
      print("네트워크 오류: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardDeviceWidth = 500;
    final standardDeviceHeight = 350;

    Color getStatusBoxColor(String status) {
      switch (status) {
        case 'ORDERED':
          return PRIMARY_COLOR; // ORDERED 상태에 해당하는 색상
        case 'REQUEST':
          return PRIMARY_COLOR; // REQUEST 상태에 해당하는 색상
        case 'CANCELED':
          return PRIMARY_COLOR; // CANCELED 상태에 해당하는 색상
        case 'COMPLETE':
          return PRIMARY_COLOR; // COMPLETE 상태에 해당하는 색상
        default:
          return PRIMARY_COLOR; // 기본 색상
      }
    }

// 주문 상태에 따라 텍스트를 반환하는 함수 정의
    String getStatusText(String status) {
      switch (status) {
        case 'ORDERED':
          return '대기'; // ORDERED 상태에 해당하는 텍스트
        case 'REQUEST':
          return '접수'; // REQUEST 상태에 해당하는 텍스트
        case 'CANCELED':
          return '취소'; // CANCELED 상태에 해당하는 텍스트
        case 'COMPLETE':
          return '완료'; // COMPLETE 상태에 해당하는 텍스트
        default:
          return ''; // 기본 텍스트
      }
    }

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
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
                        contentPadding: EdgeInsets.zero, // 내용의 여백 제거
                        hintText: startingDate != null ? DateFormat('yyyy-MM-dd').format(startingDate!) : '시작일 선택',
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 8 * (deviceWidth / standardDeviceWidth),
                      ),
                      textAlign: TextAlign.center, // 텍스트를 가운데 정렬
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
                        fontSize: 8 * (deviceWidth / standardDeviceWidth),
                      ),
                      textAlign: TextAlign.center,
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
                    borderRadius: BorderRadius.circular(10.0), // 둥근 모서리 반지름
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
                    fontSize: 11 * (deviceWidth / standardDeviceWidth), // 버튼 텍스트 크기
                  ),
                ),
              ),

              SizedBox(width: 10 * (deviceWidth / standardDeviceWidth))
            ],
          ),
          SizedBox(height: 3 * (deviceHeight / standardDeviceHeight)),
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                int totalQuantity = order['menus'].fold(0, (prev, menu) => prev + menu['quantity']);
                final formatter = NumberFormat('#,###');
                String formattedTotalPrice = formatter.format(order['price']);
                // 주문 시간에서 날짜와 시간 추출
                DateTime dateTime1 = DateTime.parse(order['orderTime']);
                DateTime dateTime = dateTime1.add(Duration(minutes: order['eta']));
                String timeOfDay = "";
                String formattedTime1 = "${dateTime1.year}-${dateTime1.month.toString().padLeft(2, '0')}-${dateTime1.day.toString().padLeft(2, '0')} ${dateTime1.hour.toString().padLeft(2, '0')}:${dateTime1.minute.toString().padLeft(2, '0')}";
                String formattedTime = "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
                List<String> dateTimeParts = formattedTime.split(" ");
                String time = dateTimeParts[1].substring(0, 5);
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
                String menuList = order['menus'].map((menu) {
                  String optionText = '';
                  if (menu['options'] != null && menu['options'].isNotEmpty) {
                    optionText = menu['options']
                        .map((option) =>
                    '${option['optionName']} ${option['selectedOption']}')
                        .join(' ');
                  }

                  return '${menu['menuName']} $optionText ${menu['quantity']}개';
                }).join(' / ');
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
                                '도착 시간',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 7 * (deviceWidth / standardDeviceWidth),
                                ),
                              ),
                              SizedBox(height: 2 * (deviceHeight / standardDeviceHeight)),
                              Text(
                                timeOfDay,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 7 * (deviceWidth / standardDeviceWidth),
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
                                menuList,
                                style: TextStyle(
                                  fontSize: 8 * (deviceWidth / standardDeviceWidth),
                                ),
                                overflow: TextOverflow.ellipsis, // 텍스트 오버플로우 시 생략 부호 표시
                                maxLines: 1, // 최대 표시 줄 수 (생략 부호 표시를 위해 적절한 값을 설정)
                              ),
                              SizedBox(
                                height: 6 * (deviceHeight / standardDeviceHeight),
                              ),
                              Row(children: [
                                Text(
                                  '주문자 : ${order['nickname'] != null ? "${order['nickname']}" : "고객님"}  ',
                                  style: TextStyle(
                                    fontSize: 8 * (deviceWidth / standardDeviceWidth),
                                    color: Color(0xFF9B5748),
                                  ),
                                ),
                                Container(
                                  width: 30 * (deviceWidth / standardDeviceWidth),
                                  decoration: BoxDecoration(
                                    color: getStatusBoxColor(order['status']),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      getStatusText(order['status']),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 7 * (deviceWidth / standardDeviceWidth),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 2 * (deviceHeight / standardDeviceHeight),),
                                Container(
                                  width: 30 * (deviceWidth / standardDeviceWidth),
                                  decoration: BoxDecoration(
                                    color: order['takeoutYn'] ? MINT : Colors.red,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        order['takeoutYn'] ? '매장' : '포장',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 7 * (deviceWidth / standardDeviceWidth),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],),
                              SizedBox(
                                height: 6 * (deviceHeight / standardDeviceHeight),
                              ),
                              Text(
                                "$formattedTime1",
                                style: TextStyle(
                                  fontSize: 8 * (deviceWidth / standardDeviceWidth),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 110 * (deviceWidth / standardDeviceWidth),
                        ),
                        // 세번째 컨테이너 (버튼)
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, // 컨테이너를 가로로 배치
                            children: [
                              Container(
                                width: 50 * (deviceWidth / standardDeviceWidth),
                                height: 60 * (deviceHeight / standardDeviceHeight),
                                child:ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          contentPadding: EdgeInsets.all(20),
                                          content: Container(
                                            width: 200 * (deviceWidth / standardDeviceWidth),
                                            height: 280 * (deviceHeight / standardDeviceHeight),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
                                                children: [
                                                  // 모달 다이얼로그 내용
                                                  Text('주문 정보', style: TextStyle(fontSize: 25, height: 2)),
                                                  Text('주문 시간: $formattedTime1', style: TextStyle(fontSize: 20, height: 2)),
                                                  Text('도착 시간: $formattedTime', style: TextStyle(fontSize: 20, height: 2)),
                                                  Text('주문자 번호: ${order['memberId']}', style: TextStyle(fontSize: 20, height: 2)),
                                                  Text('주문자 : ${order['nickname'] != null ? "${order['nickname']}" : "고객님"}  ', style: TextStyle(fontSize: 20, height: 2)),
                                                  Text('매장/포장: ${order['takeoutYn'] ? '매장' : '포장'}', style: TextStyle(fontSize: 20, height: 2)),
                                                  Text('총 메뉴 수량: $totalQuantity', style: TextStyle(fontSize: 20, height: 2)),
                                                  // 다른 주문 정보 출력...

                                                  // 메뉴 목록 출력
                                                  Text('주문 메뉴 목록:', style: TextStyle(fontSize: 20, height: 2)),
                                                  SizedBox(height: MediaQuery.of(context).size.height * 0.03 ,),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: order['menus'].map<Widget>((menu) {
                                                      String optionText = '';
                                                      if (menu['options'] != null && menu['options'].isNotEmpty) {
                                                        optionText = menu['options']
                                                            .map<String>((option) => '- ${option['optionName']} ${option['selectedOption']}\n')
                                                            .join(' ');
                                                      }

                                                      return Text(
                                                        '${menu['menuName']} ${optionText.isNotEmpty ?'\n$optionText' : ''} ${menu['quantity']}개',
                                                        style: TextStyle(fontSize: 20, height: 2, color: PRIMARY_COLOR),
                                                      );
                                                    }).toList(),
                                                  ),
                                                  Text('총 주문 가격: $formattedTotalPrice 원', style: TextStyle(fontSize: 27, height: 3)),
                                                ],
                                              ),

                                            ),
                                          ),
                                          actions: [
                                            // 뒤로가기 버튼 추가
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('확인', style: TextStyle(fontSize: 18),),
                                              style: ElevatedButton.styleFrom(
                                                primary: PRIMARY_COLOR, // Set the button color
                                                fixedSize: Size(200, 50),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5.0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xff0da619),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Color(0xFFACACAC),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  child: Text(
                                    '상세\n보기',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8 * (deviceWidth / standardDeviceWidth),
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
