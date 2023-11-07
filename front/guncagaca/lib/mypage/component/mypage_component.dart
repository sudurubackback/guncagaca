import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:guncagaca/common/const/colors.dart';
import 'package:guncagaca/jjim/view/jjim_screen.dart';
import 'package:guncagaca/mypage/nickname.dart';
import 'package:guncagaca/myreview/view/review_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../common/utils/oauth_token_manager.dart';
import '../../kakao/main_view_model.dart';
import '../../orderStatus/order_page.dart';
import '../../point/component/point_list.dart';
import '../../point/view/point_screen.dart';

import '../../common/utils/dio_client.dart';
import '../controller/mypage_controller.dart';

class MypageComponent extends StatefulWidget {
  final MainViewModel mainViewModel;

  MypageComponent({
    required this.mainViewModel
  });

  @override
  _MypageComponentState createState() => _MypageComponentState();
}

class _MypageComponentState extends State<MypageComponent> {
  Map<String, dynamic> myData = {};
  final token = TokenManager().token;

  @override
  void initState() {
    super.initState();
    loadMyDataFromAPI();
  }

  String baseUrl = dotenv.env['BASE_URL']!;
  Dio dio = DioClient.getInstance();

  Future<String?> getEmailFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }

  Future<void> loadMyDataFromAPI() async {
    String? email = await getEmailFromPreferences();

    print(email);
    if (email != null) {
      try {
        Response response = await dio.get(
          "$baseUrl/api/member/mypage",
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Email': email,
            },
          ),
        );

        if (response.statusCode == 200) {

          setState(() {
            myData = response.data;
          });

          print(myData);
        } else {
          print('데이터 로드 실패, 상태 코드: ${response.statusCode}');
        }
      } catch (e) {
        print('에러: $e');

      }
    } else {
      print('이메일이 없습니다.');
    }
  }

  @override
  Widget build(BuildContext context) {
    MypageController mypageController = MypageController(mainViewModel : widget.mainViewModel);

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(
              top: 10.0,
              left: 40.0,
              right: 40.0,
              bottom: 20.0,
            ),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Align(

                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${myData['nickname'] ?? "회원"} 님 안녕하세요',
                        style: TextStyle(fontSize: 25.0),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  'assets/image/coffeebean.png',
                  width: 40,
                  height: 40,
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xff9B5748),
            height: 2.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.25,
            margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
            padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
            decoration: BoxDecoration(
              color: Color(0xffF8E9D7),
              border: Border.all(
                color: Color(0xff9B5748),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OrderPage(mainViewModel: widget.mainViewModel,)),
                          );
                        },
                        child: Image.asset(
                          'assets/image/order.png',
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OrderPage(mainViewModel: widget.mainViewModel,)),
                          );
                        },
                        child: const Text(
                          '주문내역',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ReviewScreen(mainViewModel: widget.mainViewModel,)),
                          );
                        },
                        child: Image.asset(
                          'assets/image/review.png',
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ReviewScreen(mainViewModel: widget.mainViewModel,)),
                          );
                        },
                        child: const Text(
                          '리뷰',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => JjimScreen(mainViewModel: widget.mainViewModel,)),
                          );
                        },
                        child: Image.asset(
                          'assets/image/jjim.png',
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => JjimScreen(mainViewModel: widget.mainViewModel,)),
                          );
                        },
                        child: const Text(
                          '찜',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 버튼 두 개
          Container(
            padding: const EdgeInsets.only(bottom: 30.0,top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSquareButton(
                    context,
                    '닉네임 변경',
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NicknamePage(mainViewModel: widget.mainViewModel,nickName: myData['nickname'],)),
                      );
                    }
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                _buildSquareButton(
                    context,
                    '로그아웃',
                        () {
                      mypageController.showDialogLogOut(context);
                    }
                ),
              ],
            ),
          ),


          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.08,
            padding: EdgeInsets.only(left: 50.0, right: 70.0),
            decoration: BoxDecoration(
              // color: PRIMARY_COLOR,
              border: Border(
                top: BorderSide(width: 2.0, color: PRIMARY_COLOR),
                bottom: BorderSide(width: 2.0, color: PRIMARY_COLOR),
              ),
              // borderRadius: BorderRadius.circular(20.0),
            ),
            child: InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => PointScreen(mainViewModel: widget.mainViewModel,)), // PasswordChangePage로 이동
                // );
              },
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '포인트',
                      style: TextStyle(fontSize: 20,),
                    ),
                    Image.asset(
                      'assets/image/point.png',
                      width: 40.0,
                      height: 40.0,
                    ),
                  ],
                ),


              ),
            ),
          ),


          PointList(mainViewModel: widget.mainViewModel,),
        ],
      ),
    );

  }
  Widget _buildSquareButton(BuildContext context, String title, Function() onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Color(0xff9B5748),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}


