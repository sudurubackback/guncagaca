import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:guncagaca/kakao/main_view_model.dart';
import 'package:guncagaca/kakao/kakao_login.dart';

import '../../common/utils/dio_client.dart';


class PointList extends StatefulWidget {
  final MainViewModel mainViewModel;

  PointList ({ required this.mainViewModel});

  @override
  _PointListState createState() => _PointListState();
}

class _PointListState extends State<PointList> {



  List<Map<String, dynamic>> dummyPoints = [];

  @override
  void initState() {
    super.initState();
    loadPointsFromAPI();
  }

  Future<void> loadPointsFromAPI() async {
    final email = widget.mainViewModel.user?.kakaoAccount?.email;

    if (email != null) {
      // String baseUrl = dotenv.env['BASE_URL']!;
      Dio dio = DioClient.getInstance();
      print(email);
      print("통신");

      try {
        Response response = await dio.get(
          "http://k9d102.p.ssafy.io:8081/api/member/mypage/point",
          options: Options(
            headers: <String, String>{
              'Content-Type': 'application/json', // JSON 데이터를 보내는 것을 명시
              'email': email.toString(),
            },
          ),
        );

        if (response.statusCode == 200) {
          List<dynamic> jsonData = json.decode(response.data);
          dummyPoints = List<Map<String, dynamic>>.from(jsonData);
          print(dummyPoints);
          print("제대로 옴");
          setState(() {});
        } else {
          print('데이터 로드 실패, 상태 코드: ${response.statusCode}');
        }
      } catch (e) {
        print('에러: $e');
      }
    } else {
      print(email);
    }


  }


  @override
  Widget build(BuildContext context) {
    return dummyPoints == null || dummyPoints.isEmpty
        ? Center(
      child: Text(
        "포인트함이 비었습니다.",
        style: TextStyle(fontSize: 18.0),
      ),
    )
        : ListView.builder(
      itemCount: dummyPoints.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == dummyPoints.length) {
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
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(
                        dummyPoints[index]['img'],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.03), // 오른쪽에 20만큼의 패딩
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          dummyPoints[index]['name'],
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                        Text(
                          dummyPoints[index]['point'].toString() + ' p',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
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
