import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/utils/dio_client.dart';
import '../../common/utils/oauth_token_manager.dart';
import '../../kakao/main_view_model.dart';

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

  Future<String?> getEmailFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }

  Future<void> loadOrdersFromAPI() async {
    String? email = await getEmailFromPreferences();

    if (email != null) {
      // 주문 내역 가져오기
      final String apiUrl = '$baseUrl/api/order/member/${widget.storeId}';
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
        setState(() {});
      } else {
        print('데이터 로드 실패, 상태 코드: ${orderResponse.statusCode}');
      }
    }
  }

  String formatOrderTime(String datetimeStr) {
    DateTime datetime = DateTime.parse(datetimeStr);
    // 날짜 및 시간 형식
    String year = datetime.year.toString().substring(2, 4);
    String month = datetime.month.toString().padLeft(2, '0');
    String day = datetime.day.toString().padLeft(2, '0');
    // String period = datetime.hour < 12 ? "AM" : "PM";
    // String hour = (datetime.hour <= 12 ? datetime.hour : datetime.hour - 12).toString().padLeft(2, '0');
    // String minute = datetime.minute.toString().padLeft(2, '0');

    return "$year.$month.$day ";
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
        :
    ListView.builder(
          itemCount: storeOrders.length,
          itemBuilder: (BuildContext context, int index) {
          if (index == storeOrders.length) {
            return Center(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                    // Text(
                    //   "주문내역이 없습니다.",
                    //   style: TextStyle(fontSize: 18.0),
                    // ),
                  ],
                )
            );
          }
          return
            Padding(
              padding: EdgeInsets.only(top: 20.0, ),
              child: Column(
                children:[
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬을 추가
                      children: [
                        Text(
                          formatOrderTime(storeOrders[index]['orderTime']),
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          storeOrders[index]['menus'].length > 1
                              ? storeOrders[index]['menus'][0]['menuName'] +
                              " 외 " +
                              (storeOrders[index]['menus'].length - 1).toString()
                              : storeOrders[index]['menus'][0]['menuName'].toString(),
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${storeOrders[index]['menus'][0]['totalPrice'].toString()}원",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Color(0xffD9D9D9),
                    thickness: 1,
                  ),
                ],
              ),
            );

      },
    );
  }
}


