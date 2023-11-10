import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:guncagaca/kakao/main_view_model.dart';
import 'package:guncagaca/common/utils/dio_client.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../common/layout/default_layout.dart';
import '../../common/utils/oauth_token_manager.dart';
import '../../mypage/component/order_store_list.dart';
import '../../store/view/store_detail_screen.dart';

class PointList extends StatefulWidget {
  final MainViewModel mainViewModel;

  PointList({required this.mainViewModel});

  @override
  _PointListState createState() => _PointListState();
}

class _PointListState extends State<PointList> {
  List<Map<String, dynamic>> dummyPoints = [];
  final token = TokenManager().token;

  @override
  void initState() {
    super.initState();
    loadPointsFromAPI();
  }

  String baseUrl = dotenv.env['BASE_URL']!;
  Dio dio = DioClient.getInstance();

  Future<String?> getEmailFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }

  Future<void> loadPointsFromAPI() async {
    String? email = await getEmailFromPreferences();

    if (email != null) {
      try {
        final response = await dio.get(
          "$baseUrl/api/member/mypage/point",
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Email': email,
            },
          ),
        );

        if (response.statusCode == 200) {
          List<dynamic> jsonData = response.data;
          dummyPoints = List<Map<String, dynamic>>.from(jsonData);
          print(dummyPoints);
          setState(() {});
        } else {
          print('데이터 로드 실패, 상태 코드: ${response.statusCode}');
        }
      } catch (e) {
        print('에러: $e');
      }
    }
  }

  void _goToStoreDetail(String cafeName, int id) {
    Get.to(() => StoreDetailScreen(storeId: id, mainViewModel: widget.mainViewModel,)
      );
  }

  @override
  Widget build(BuildContext context) {
    return dummyPoints.isEmpty
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
                padding: EdgeInsets.symmetric(vertical: 20),
                child:
                GestureDetector(
                  onTap: () => _goToStoreDetail(dummyPoints[index]['name'], dummyPoints[index]['storeId']),
                  child: Text(
                  point['name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                  onTap: () => _goToStoreDetail(dummyPoints[index]['name'], dummyPoints[index]['storeId']),
                  child: Container(
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
                  ),
                  Text(
                    point['point'].toString() + ' p',
                    style: TextStyle(fontSize: 28.0),
                  ),
                ],
              ),
                  SizedBox(height: 10,),
                  Expanded(
                    child:
                    OrderStoreList(mainViewModel: widget.mainViewModel, storeId:point['storeId']),
                  ),
            ],
          ),
        );
      },
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.6,
        enableInfiniteScroll: false,
        initialPage: 0,
        viewportFraction: 0.90,
      ),
    );
  }
}
