import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../common/utils/dio_client.dart';
import '../../kakao/main_view_model.dart';

class ReviewList extends StatefulWidget {

  @override
  _ReviewListState createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  late SharedPreferences prefs;
  List<Map<String, dynamic>> dummyReviews = [];

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  String baseUrl = dotenv.env['BASE_URL']!;
  Dio dio = DioClient.getInstance();

  // SharedPreferences 초기화
  Future<void> _initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    loadDummyReviews();
  }


  void loadDummyReviews() async {
    final token = prefs.getString('accessToken');

    if (token != null) {
      // String baseUrl = dotenv.env['BASE_URL']!;
      print(token);
      print("통신");

      try {
        Response response = await dio.get(
          "$baseUrl/api/store/mypage/reviews",
          options: Options(
            headers: <String, String>{
              'Content-Type': 'application/json', // JSON 데이터를 보내는 것을 명시
              'Authorization': token.toString(),
            },
          ),
        );

        if (response.statusCode == 200) {
          List<dynamic> jsonData = json.decode(response.data);
          dummyReviews = List<Map<String, dynamic>>.from(jsonData);
          print(dummyReviews);
          print("제대로 옴");
          setState(() {});
        } else {
          print('데이터 로드 실패, 상태 코드: ${response.statusCode}');
        }
      } catch (e) {
        print('에러: $e');
      }
    } else {
      print(token);
    }

  }


  @override
  Widget build(BuildContext context) {
    return dummyReviews.isEmpty
        ? Center(
      child: Text(
        "리뷰가 없습니다.",
        style: TextStyle(fontSize: 18.0),
      ),
    )
    : ListView.builder(
      itemCount: dummyReviews.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == dummyReviews.length) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage(
                                dummyReviews[index]['img'],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          dummyReviews[index]['name'],
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 25),
                        SizedBox(width: 10,),
                        Text(
                          dummyReviews[index]['star'].toString(),
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color(0xffF8E9D7),
                    border: Border.all(
                      color: Color(0xff9B5748),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    dummyReviews[index]['comment'],
                    style: TextStyle(fontSize: 16.0),
                  ),
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
