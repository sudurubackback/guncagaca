import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guncagacaonwer/order/api/trackingpage_api_service.dart';
import 'package:guncagacaonwer/order/models/orderlistmodel.dart';
import 'package:intl/intl.dart';

class OrderTrackingPage extends StatefulWidget {

  @override
  _OrderTrackingPageState createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {

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
  List<StoreOrderResponse> orders = [];
  late ApiService apiService;

  static final storage = FlutterSecureStorage();

  Future<void> setupApiService() async {
    String? accessToken = await storage.read(key: 'accessToken');
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
    String startDate = startingDateController.text;
    String endDate = endingDateController.text;

    // 가져온 날짜로 주문을 조회합니다.
    fetchOrders(startDate, endDate);
  }

  // 주문 처리 데이터 get
  // 주문 처리 데이터 get
  Future<void> fetchOrders(String startDate, String endDate) async {
    try {
      final ownerResponse = await apiService.getOwnerInfo();
      int storeId = ownerResponse.storeId;

      List<StoreOrderResponse> orderList = await apiService.getStoreOrdersForDaterRange(storeId, startDate, endDate);
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
              itemCount: orders.length,
              itemBuilder: (BuildContext context, int index) {
                final order = orders[index];
                final formatter = NumberFormat('#,###');
                int totalQuantity = order.menuList.map((menu) => menu.quantity).reduce((a, b) => a + b);
                String formattedTotalPrice = formatter.format(order.price);
                // 주문 시간에서 날짜와 시간 추출
                DateTime dateTime = DateTime.parse(order.orderTime);
                String timeOfDay = "";
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
