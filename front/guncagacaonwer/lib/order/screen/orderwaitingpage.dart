import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared\_preferences/shared\_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guncagacaonwer/order/api/waitingpage_api_service.dart';
import 'package:guncagacaonwer/order/models/ordercancelmodel.dart';
import 'package:guncagacaonwer/order/models/orderlistmodel.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';

import '../../common/const/colors.dart';
import '../../common/dioclient.dart';
import '../../main.dart';

class OrderWaitingPage extends StatefulWidget {

  @override
  _OrderWaitingPageState createState() => _OrderWaitingPageState();
}

class _OrderWaitingPageState extends State<OrderWaitingPage> {
  List<Map<String, dynamic>> orders = []; // ordersData 리스트 선언
  late ApiService apiService;


  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> setupApiService() async {
    final prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    String? email = prefs.getString('email');
    print("email : $email");
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor(accessToken));
    dio.interceptors.add(LogInterceptor(responseBody: true));
    apiService = ApiService(dio);
  }

  @override
  void initState() {
    super.initState();
    setupApiService().then((_) {
      fetchOrders();
    });
  }
  String baseUrl = 'https://k9d102.p.ssafy.io';
  Dio dio = DioClient.getInstance();

  // 주문 접수 리스트 (get)
  Future<void> fetchOrders() async {
    try {
      final ownerResponse = await apiService.getOwnerInfo();
      print("주문접수");
      print(ownerResponse.email);
      int storeId = ownerResponse.storeId;
      print(storeId);
      if (storeId != null) {
        final response = await dio.get(
          "http://k9d102.p.ssafy.io:8083/api/order/list/$storeId/1",
        );

        if (response.statusCode == 200) {
          // API 응답이 Map 형식인지 확인
          if (response.data is Map<String, dynamic>) {
            Map<String, dynamic> jsonData = response.data;
            // 'data' 키에 해당하는 주문 목록을 가져옵니다.
            orders = List<Map<String, dynamic>>.from(jsonData['data']);
            print(orders);

            // orders를 활용하여 주문 목록을 처리하는 로직을 작성하세요.
            // 예를 들어, 주문 목록을 화면에 출력하거나 다른 작업을 수행할 수 있습니다.

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

  // 주문 접수 요청
  Future<void> requestOrder(String orderId) async {
    try {
      final ownerResponse = await apiService.getOwnerInfo();
      final prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      if (orderId != null) {
        final response = await dio.post(
          'https://k9d102.p.ssafy.io/api/order/request/$orderId',
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken'},
          ),
        );

        if (response.statusCode == 200) {
          print("주문성공");
          fetchOrders();
          Fluttertoast.showToast(
            msg: "주문이 성공적으로 접수되었습니다.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );

          // 소리 재생
          await _audioPlayer.setAsset('assets/sound/sound1.mp3');
          await _audioPlayer.play();
          print("화면이 새로 고쳐집니다.");

        } else {
          print('데이터 로드 실패, 상태 코드: ${response.statusCode}');
          Fluttertoast.showToast(
            msg: "데이터 로드 실패",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      }
    } catch (e) {
      print("네트워크 오류: $e");
      Fluttertoast.showToast(
        msg: "네트워크 오류",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }



  // 취소 사유 리스트
  List<String> cancelReasons = ['현재 너무 많은 고객님으로 인해 시간내 조리가 어렵습니다. 죄송합니다.', '재료가 소진되어 주문이 어렵습니다 죄송합니다.', '매장 내 인원이 많아 포장 주문으로 부탁드립니다. 죄송합니다.', '현재 주문이 어렵습니다. 죄송합니다.'];
  String selectedReason = "";

  // 주문 취소 요청
  Future<void> cancelOrder(String orderId,String receiptId,String reason) async {
    try {
      final ownerResponse = await apiService.getOwnerInfo();
      final prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      if (orderId != null) {
        final response = await dio.post(
          'https://k9d102.p.ssafy.io/api/order/cancel',
          options: Options(
            headers: {'Authorization': 'Bearer ${accessToken}',}, // 헤더에 이메일 추가
          ),
          data: {'orderId': orderId,'receiptId': receiptId, 'reason': reason},
        );

        if (response.statusCode == 200) {
          print("주문취소");
          fetchOrders();
          Fluttertoast.showToast(
            msg: "주문취소가 완료되었습니다.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          // 소리 재생
          await _audioPlayer.setAsset('assets/sound/sound1.mp3'); // 소리 파일 경로에 맞게 수정
          await _audioPlayer.play();

          print("화면이 새로 고쳐집니다.");
        } else {
          print('데이터 로드 실패, 상태 코드: ${response.statusCode}');
          Fluttertoast.showToast(
            msg: "데이터 로드 실패",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      }
    } catch (e) {
      print("네트워크 오류: $e");
      Fluttertoast.showToast(
        msg: "네트워크 오류",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  // 취소 요청 모달
// 취소 요청 모달
  Future<void> showCancelDialog(String orderId, String receiptId) async {
    String selectedReason = cancelReasons.first;  // 추가: 취소 사유 초기값 설정
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
              child: Text('확인',  style: TextStyle(color: PRIMARY_COLOR, fontSize: 20)),
              onPressed: () async {
                if (selectedReason.isNotEmpty) {
                  await cancelOrder(orderId, receiptId, selectedReason);  // 추가: 취소 사유 전달
                  Navigator.of(context).pop();
                } else {
                  // 취소 사유가 선택되지 않았을 경우 사용자에게 메시지 표시 또는 다른 조치 수행
                  print("취소 사유를 선택하세요.");
                }
              },
            ),
            TextButton(
              child: Text('취소', style: TextStyle(color: PRIMARY_COLOR,fontSize: 20) ),
              onPressed: () {
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
                        // 두번째 컨테이너 (메뉴 총 개수, 메뉴-개수, 도착 예정 시간)
                        Container(
                          width: 220 * (deviceWidth / standardDeviceWidth),
                          margin: EdgeInsets.only(top: 3 * (deviceHeight / standardDeviceHeight)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 4 * (deviceHeight / standardDeviceHeight),
                              ),
                              Row(children: [
                                Text(
                                  "$formattedTotalPrice원 / ",
                                  style: TextStyle(
                                    fontSize: 8 * (deviceWidth / standardDeviceWidth),
                                  ),
                                ),
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
                                menuList,
                                style: TextStyle(
                                    fontSize: 8 * (deviceWidth / standardDeviceWidth),
                                    color: Color(0xFF9B5748)
                                ),
                                overflow: TextOverflow.ellipsis, // 텍스트 오버플로우 시 생략 부호 표시
                                maxLines: 1, // 최대 표시 줄 수 (생략 부호 표시를 위해 적절한 값을 설정)
                              ),
                              SizedBox(
                                height: 6 * (deviceHeight / standardDeviceHeight),
                              ),
                              Text("$formattedTime1",
                                style: TextStyle(
                                  fontSize: 8 * (deviceWidth / standardDeviceWidth),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 세번째 컨테이너 (버튼)
                        Row(children: [
                          Container(
                            width: 40 * (deviceWidth / standardDeviceWidth),
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
                                                Text('주문 시간: $formattedTime', style: TextStyle(fontSize: 20, height: 2)),
                                                Text('도착 시간: $formattedTime1', style: TextStyle(fontSize: 20, height: 2)),
                                                Text('주문자 번호: ${order['memberId']}', style: TextStyle(fontSize: 20, height: 2)),
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
                                primary: Colors.white,
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
                                  color: Colors.black,
                                  fontSize: 8 * (deviceWidth / standardDeviceWidth),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3 * (deviceWidth / standardDeviceWidth),
                          ),
                          Container(
                            child : Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      // 접수하기 버튼 클릭 시 수행할 동작 추가
                                      await requestOrder(order['id']);
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
                                      showCancelDialog(order['id'],order['receiptId']);
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
                        ],),

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
