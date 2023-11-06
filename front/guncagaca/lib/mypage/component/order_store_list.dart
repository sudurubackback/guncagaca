import 'dart:ffi';

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

class OrderStoreList extends StatefulWidget {
  final MainViewModel mainViewModel;
  final int storeId;

  const OrderStoreList({required this.mainViewModel, required this.storeId});

  @override
  _OrderStoreListState createState() => _OrderStoreListState();
}

class _OrderStoreListState extends State<OrderStoreList> {
  List<Map<String, dynamic>> storeOrders = [];
  final token = TokenManager().token;

  @override
  void initState() {
    super.initState();
    loadOrdersFromAPI();
  }

  String baseUrl = dotenv.env['BASE_URL']!;

  Dio dio = DioClient.getInstance();


  Future<void> loadOrdersFromAPI() async {
    final email = widget.mainViewModel.user?.kakaoAccount?.email;
    print('storeId' + widget.storeId.toString());
    if (email != null) {
      try {
        // 주문 내역 가져오기
        final String apiUrl = '$baseUrl/api/store/${widget.storeId}';
        var orderResponse = await dio.get(
            apiUrl,
            options: Options(
                headers: {
                  'Authorization': "Bearer $token",
                }
            ),
            queryParameters: {
              'storeId': widget.storeId
            }
        );

        if (orderResponse.statusCode == 200) {
          List<dynamic> jsonData = orderResponse.data;
          storeOrders = List<Map<String, dynamic>>.from(jsonData);

          print(storeOrders);
          setState(() {});
        } else {
          print('데이터 로드 실패, 상태 코드: ${orderResponse.statusCode}');
        }
      } catch (e) {
        print('에러: $e');
      }
    }
  }

  String formatOrderTime(String datetimeStr) {
    DateTime datetime = DateTime.parse(datetimeStr);

    // 날짜 및 시간 형식
    String year = datetime.year.toString().substring(2, 4);
    String month = datetime.month.toString().padLeft(2, '0');
    String day = datetime.day.toString().padLeft(2, '0');
    String period = datetime.hour < 12 ? "AM" : "PM";
    String hour = (datetime.hour <= 12 ? datetime.hour : datetime.hour - 12).toString().padLeft(2, '0');
    String minute = datetime.minute.toString().padLeft(2, '0');

    return "$year.$month.$day $period $hour:$minute";
  }

  @override
  Widget build(BuildContext context) {
    return storeOrders.isEmpty
        ? Center(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
              Text(
                "주문내역이 없습니다.",
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          )
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
                      Icon(Icons.access_time, color: Colors.grey),
                      SizedBox(width: 8.0),
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
                                builder: (context) => OrderDetailScreen(
                                  orderHistory: storeOrders[index],
                                  mainViewModel: widget.mainViewModel,),
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
                                    ? storeOrders[index]['menus'][0]['menuName'] +
                                    " 외 " +
                                    (storeOrders[index]['menus'].length - 1).toString() +
                                    "개\n" +
                                    storeOrders[index]['price'].toString() +
                                    "원"
                                    : storeOrders[index]['menus'][0]['menuName']+
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
                                'ORDERED': '접수 대기',
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
                                      loadOrdersFromAPI();
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
}


