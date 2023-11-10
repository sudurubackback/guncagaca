import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:guncagaca/common/const/colors.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../common/utils/dio_client.dart';
import '../../common/utils/oauth_token_manager.dart';
import '../../kakao/main_view_model.dart';
import '../../store/view/store_detail_screen.dart';

class JjimList extends StatefulWidget {
  final MainViewModel mainViewModel;

  JjimList({ required this.mainViewModel});

  @override
  _JjimListState createState() => _JjimListState();
}

class _JjimListState extends State<JjimList> {
  bool? isLiked;
  final token = TokenManager().token;
  late SharedPreferences prefs;
  List<Map<String, dynamic>> dummyJjims = [];

  @override
  void initState() {
    super.initState();
    loadJjims();
  }

  String baseUrl = dotenv.env['BASE_URL']!;
  Dio dio = DioClient.getInstance();

  Future<void> loadJjims() async {

    if (token != null) {
      print("통신 $token");

      try {
        final response = await dio.get(
          "$baseUrl/api/store/mypage/like-store",
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );

        if (response.statusCode == 200) {
          List<dynamic> jsonData = response.data;
          dummyJjims = List<Map<String, dynamic>>.from(jsonData);
          print(dummyJjims);
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

  Future<void> toggleFavorite(int storeId) async {
    final String apiUrl = "$baseUrl/api/store/$storeId/like";

    final response = await dio.post(
        apiUrl,
        options: Options(
            headers: {
              'Authorization': "Bearer $token",
            }
        )
    );

    if (response.statusCode == 200) {
      print(response.data);
      setState(() {
        isLiked = response.data['liked'];
      });
    } else {
      print("Failed to toggle favorite status.");
    }
  }

  void _goToStoreDetail(String cafeName, int id) {
    print("스토어아이디 $id");
    Get.to(() => StoreDetailScreen(storeId: id, mainViewModel: widget.mainViewModel,),
    );
  }

  void _confirmDelete(int storeId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          contentPadding: EdgeInsets.all(20.0),
          content: Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.8,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.2,
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  SizedBox(height: 10),
                  const Center(
                    child:
                    Text(
                      '찜 해제하시겠습니까?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Image.asset(
                      'assets/image/close2.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: PRIMARY_COLOR,
                  ),
                  child: Text('확인', style: TextStyle(color: Color(0xffffffff))),
                        onPressed: () async {
                          await toggleFavorite(storeId);
                          setState(() {
                            dummyJjims.removeWhere((jjim) => jjim['storeId'] == storeId);
                          });
                          print("찜 해제");
                          Navigator.of(context).pop();

                        },
                ),
                SizedBox(width: 30),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: PRIMARY_COLOR,
                  ),
                  child: Text('취소', style: TextStyle(color: Color(0xffffffff))),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            SizedBox(height: 15),
          ],
        );

      },
    );
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
        isLiked = dummyJjims[index]['liked'];
        int id = dummyJjims[index]['id'];
        print('id : ' + id.toString());
        return Container(
          margin: EdgeInsets.only(top: 15, left: 10, right: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: PRIMARY_COLOR,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.only(top: 13, bottom: 13, left: 16, right: 20),
            title: GestureDetector(
              onTap: () => _goToStoreDetail(dummyJjims[index]['cafeName'], dummyJjims[index]['storeId']),
              child: Row(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dummyJjims[index]['cafeName'],
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          dummyJjims[index]['address'],
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          dummyJjims[index]['description'].length > 15
                              ? dummyJjims[index]['description'].substring(0, 15) + "..."
                              : dummyJjims[index]['description'],
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _confirmDelete(dummyJjims[index]['storeId']),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/image/h2.png'
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
