import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../common/utils/dio_client.dart';

class JjimList extends StatefulWidget {

  @override
  _JjimListState createState() => _JjimListState();
}

class _JjimListState extends State<JjimList> {
  late SharedPreferences prefs;
  List<Map<String, dynamic>> dummyJjims = [];
  // List<bool> toggleList = [];

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
    loadDummyJjims();
  }

  void loadDummyJjims() async {
    final token = prefs.getString('accessToken');

    if (token != null) {
      // String baseUrl = dotenv.env['BASE_URL']!;
      print(token);
      print(prefs.getString('email'));
      print("통신");

      try {
        Response response = await dio.get(
          "http://k9d102.p.ssafy.io:8085/api/store/mypage/like-store",
          options: Options(
            headers: <String, String>{
              'Content-Type': 'application/json', // JSON 데이터를 보내는 것을 명시
              'Authorization': 'Bearer $token',
            },
          ),
        );
        print("리스폰스 값");
        print(response.toString());
        print(response.data.runtimeType);

        if (response.statusCode == 200) {
          List<dynamic> jsonData = response.data;
          dummyJjims = List<Map<String, dynamic>>.from(jsonData);
          print(dummyJjims);
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

  void _toggleImage(int id) {
    int index = dummyJjims.indexWhere((item) => item['id'] == id);
    if (index != -1) {
      setState(() {
        // toggleList[index] = !toggleList[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return dummyJjims.isEmpty
        ? Center(
      child: Text(
        "찜 목록이 비었습니다.",
        style: TextStyle(fontSize: 18.0),
      ),
    )
        : ListView.builder(
      itemCount: dummyJjims.length,
      itemBuilder: (BuildContext context, int index) {
        int id = dummyJjims[index]['id'];
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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 변경된 부분
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(
                        dummyJjims[index]['img'],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    dummyJjims[index]['cafeName'],
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _toggleImage(id),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/image/h2.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
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
