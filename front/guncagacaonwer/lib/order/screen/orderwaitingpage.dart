import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guncagacaonwer/order/api/waitingpage_api_service.dart';
import 'package:guncagacaonwer/order/models/ordercancelmodel.dart';
import 'package:guncagacaonwer/order/models/orderlistmodel.dart';
import 'package:intl/intl.dart';

class OrderWaitingPage extends StatefulWidget {

  @override
  _OrderWaitingPageState createState() => _OrderWaitingPageState();
}

class _OrderWaitingPageState extends State<OrderWaitingPage> {

  List<Order> orders = [];
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
    fetchOrders();
  }

  // 주문 접수 리스트 (get)
  Future<void> fetchOrders() async {
    try {
      final ownerResponse = await apiService.getOwnerInfo();
      int storeId = ownerResponse.storeId;
      List<Order> orderList = await apiService.getWaitingList(storeId, "1");
      setState(() {
        orders = orderList;
      });
    } catch (e) {
      print(e);
    }
  }

  // 주문 접수 요청
  Future<void> requestOrder(Order order) async {
    try {
      final response = await apiService.requestOrder(order.id);
      print("주문 접수 성공 : ${response.message}");
      fetchOrders();
    } catch (e) {
      print("주문 접수 에러: $e");
    }
  }

  // 취소 사유 리스트
  List<String> cancelReasons = ['사유1', '사유2', '사유3'];
  String selectedReason = "";

  // 주문 취소 요청
  Future<void> cancelOrder(Order order) async {
    OrderCancelRequest orderCancelRequest = OrderCancelRequest(
      reason: selectedReason,
      receiptId: order.receiptId,
      orderId: order.id,
    );

    try {
      final response = await apiService.cancelOrder(orderCancelRequest);
      print("주문 취소 성공: $response");
      fetchOrders();
    } catch (e) {
      print("주문 취소 에러: $e");
    }
  }

  // 취소 요청 모달
  Future<void> showCancelDialog(Order order) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext content) {
        return AlertDialog(
          title: Text("주문 취소"),
          content: DropdownButton<String>(
            value: selectedReason,
            onChanged: (String? newValue) {
              setState(() {
                selectedReason = newValue!;
              });
            },
            items: cancelReasons.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('확인'),
              onPressed: () async {
                await cancelOrder(order);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                int totalQuantity = order.menus.map((menu) => menu.quantity).reduce((a, b) => a + b);
                final formatter = NumberFormat('#,###');
                String formattedTotalPrice = formatter.format(order.orderPrice);
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
                String menuList = order.menus.map((menu) => '${menu.menuName} ${menu.quantity}개').join(' / ');
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
                                '메뉴 [$totalQuantity]개 / '+formattedTotalPrice+"원",
                                style: TextStyle(
                                  fontSize: 8 * (deviceWidth / standardDeviceWidth),
                                ),
                              ),
                              SizedBox(
                                height: 6 * (deviceHeight / standardDeviceHeight),
                              ),
                              Text(
                                menuList,
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
                                  onPressed: () async {
                                    // 접수하기 버튼 클릭 시 수행할 동작 추가
                                    await requestOrder(order);
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
                                    showCancelDialog(order);
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
