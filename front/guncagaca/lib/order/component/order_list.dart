import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

import 'package:guncagaca/common/const/colors.dart';
import 'package:guncagaca/review_create/reviewcreate_view.dart';

import '../../common/utils/dio_client.dart';
import '../../common/utils/oauth_token_manager.dart';
import '../../kakao/main_view_model.dart';
import '../../orderdetail/view/orderdetail_screen.dart';

class OrderList extends StatefulWidget {
  final MainViewModel mainViewModel;

  const OrderList({required this.mainViewModel});

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  List<Map<String, dynamic>> storeOrders = [];
  final token = TokenManager().token;

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  String baseUrl = dotenv.env['BASE_URL']!;
  Dio dio = DioClient.getInstance();

  Future<void> loadOrders() async {
    try {
      // 주문 내역 가져오기
      final String apiUrl = '$baseUrl/api/order/member';
      var orderResponse = await dio.get(
          apiUrl,
          options: Options(
              headers: {
                'Authorization': "Bearer $token",
              }
          )
      );
      print("주문 $orderResponse");
      if (orderResponse.statusCode == 200) {
        List<dynamic> orders = orderResponse.data;

        // 모든 가게 정보를 비동기적으로 가져옵니다.
        var storeRequests = <Future>[];
        for (var order in orders) {
          int storeId = order['storeId'];
          storeRequests.add(dio.get('$baseUrl/api/store/$storeId',
              options: Options(
                  headers: {
                    'Authorization': "Bearer $token",
                  }
              )));
        }

        var storeResponses = await Future.wait(storeRequests);

        // 주문 내역과 가게 정보를 하나의 리스트로 결합합니다.
        for (var i = 0; i < orders.length; i++) {
          var storeResponse = storeResponses[i];
          print("가게 :  $storeResponse");
          if (storeResponse.statusCode == 200) {
            orders[i]['store'] = storeResponse.data;
          } else {
            // 오류 처리
            print('Store data could not be fetched for order ${orders[i]['id']}');
          }
        }

        setState(() {
          storeOrders = orders.cast<Map<String, dynamic>>();
          print("최종 : $storeOrders");
        });

      } else {
        // 오류 처리
        print('Order data could not be fetched');
      }
    } catch (e) {
      // 오류 처리
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return storeOrders.isEmpty
        ? Center(
          child: Text(
           "주문내역이 없습니다.",
           style: TextStyle(fontSize: 18.0),
          ),
        )
        : ListView.builder(
          itemCount: storeOrders.length + 1,
          itemBuilder: (BuildContext context, int index) {
          if (index == storeOrders.length) {
            return SizedBox(height: 20);
          }

          return Container(
            margin: EdgeInsets.only(top: 15, left: 10, right: 10),
            decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xff9B5748),
              width: 1.0,
              ),
            borderRadius: BorderRadius.circular(20.0),
            ),
            child: ListTile(
              contentPadding:
              EdgeInsets.symmetric(vertical: 13.0, horizontal: 16.0),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(
                  children: [
                    // 주문시간
                    Expanded(
                      child: Text(
                        formatOrderTime(storeOrders[index]['orderTime']),
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                Row(
                  children: [
                    // 가게 사진
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(
                            storeOrders[index]['store']['img'],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 주문 정보
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderDetailScreen(id: storeOrders[index]["id"], mainViewModel: widget.mainViewModel,),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                storeOrders[index]['store']['cafeName'],
                                style: TextStyle(fontSize: 18.0),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                              Text(
                                // 1개일때, 2개 이상일때
                                storeOrders[index]['menus'].length > 1
                                    ? storeOrders[index]['menus'][0]['menuName'].toString() +
                                    " 외 " +
                                    (storeOrders[index]['menus'].length - 1).toString() +
                                    "개\n" +
                                    storeOrders[index]['price'].toString() +
                                    "원"
                                    : storeOrders[index]['menus'][0]['menuName'].toString() +
                                    "\n" +
                                    storeOrders[index]['price'].toString() +
                                    "원",
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.width * 0.02,),
                        Row(
                          children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: PRIMARY_COLOR,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                            child: Text(
                              {
                                'ORDERED': '주문 대기',
                                'REQUEST': '주문 접수',
                                'CANCELED': '주문 취소',
                                'COMPLETE': '완료',
                              }[storeOrders[index]['status']] ?? '알 수 없는 상태',
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: storeOrders[index]['takeoutYn']
                                    ? Colors.green
                                    : Colors.red,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                            child: Text(
                              storeOrders[index]['takeoutYn'] ? '포장' : '매장',
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: storeOrders[index]['reviewYn']
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: BACK_COLOR, // 배경색 변경
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(color: PRIMARY_COLOR, width: 2)// 둥근 모서리 설정
                                    ),
                                  ),
                                onPressed: () {
                                // 리뷰 작성 완료 버튼 클릭 시 동작 추가
                                },
                                child: Text('리뷰 작성 완료',
                                style: TextStyle(color: Colors.black),),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: PRIMARY_COLOR, // 배경색 변경
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(color: PRIMARY_COLOR, width: 2), // 둥근 모서리 설정
                                    ),
                                  ),
                                  onPressed: () async {
                                    var result = await Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => ReviewCreatePage(
                                        cafeName: storeOrders[index]['store']['cafeName'],
                                        storeId: storeOrders[index]['store']['storeId'],
                                        orderId: storeOrders[index]['id'],
                                      )
                                      ), // ReviewCreateScreen으로 이동
                                    );
                                    if (result == 'true') {
                                      loadOrders();
                                    }
                                  },
                                  child: Text('리뷰 쓰기'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                onTap: () {
              // 알림을 눌렀을 때의 동작을 추가하세요.
            },
          ),
        );
      },
    );
  }

  String formatOrderTime(String orderTimeStr) {
    DateTime orderTime = DateTime.parse(orderTimeStr);

    String period = orderTime.hour < 12 ? "오전" : "오후";
    int hour = orderTime.hour <= 12 ? orderTime.hour : orderTime.hour - 12;
    int minute = orderTime.minute;

    return "${orderTime.year}년 ${orderTime.month}월 ${orderTime.day}일 "
        "$period ${hour.toString().padLeft(2, '0')}시 ${minute.toString().padLeft(2, '0')}분";
  }
}
