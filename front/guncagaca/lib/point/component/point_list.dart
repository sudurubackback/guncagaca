import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:guncagaca/kakao/main_view_model.dart';
import 'package:guncagaca/common/utils/dio_client.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PointList extends StatefulWidget {
  final MainViewModel mainViewModel;

  PointList({required this.mainViewModel});

  @override
  _PointListState createState() => _PointListState();
}

class _PointListState extends State<PointList> {
  late SharedPreferences prefs;
  List<Map<String, dynamic>> dummyPoints = [];

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  String baseUrl = dotenv.env['BASE_URL']!;
  Dio dio = DioClient.getInstance();

  Future<void> _initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    loadPointsFromAPI();
  }

  Future<void> loadPointsFromAPI() async {
    final email = widget.mainViewModel.user?.kakaoAccount?.email;
    final token = prefs.getString('accessToken');

    if (email != null) {
      try {
        Response response = await dio.get(
          "http://k9d102.p.ssafy.io:8081/api/member/mypage/point",
          options: Options(
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
              'email': email.toString(),
            },
          ),
        );

        if (response.statusCode == 200) {
          List<dynamic> jsonData = response.data;
          dummyPoints = List<Map<String, dynamic>>.from(jsonData);
          setState(() {});
        } else {
          print('데이터 로드 실패, 상태 코드: ${response.statusCode}');
        }
      } catch (e) {
        print('에러: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return dummyPoints == null || dummyPoints.isEmpty
        ? Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      child: Center(
        child: Text(
          "포인트함이 비었습니다.",
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    )
        : CarouselSlider.builder(
      itemCount: dummyPoints.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        Map<String, dynamic> point = dummyPoints[index];
        return Container(
          margin: EdgeInsets.only(top: 15, left: 10, right: 10),
          decoration: BoxDecoration(

            border: Border.all(
              color: Color(0xff9B5748),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20), // 위아래 패딩 10 추가
                child: Text(
                  point['name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(point['img']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    point['point'].toString() + ' p',
                    style: TextStyle(fontSize: 28.0),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.6,
        enableInfiniteScroll: true,
        initialPage: 0,
        viewportFraction: 0.90,
      ),
    );
  }
}
