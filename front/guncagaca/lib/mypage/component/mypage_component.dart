
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide Response;
import 'package:guncagaca/common/const/colors.dart';
import 'package:guncagaca/jjim/view/jjim_screen.dart';
import 'package:guncagaca/mypage/component/nickname.dart';
import 'package:guncagaca/myreview/view/review_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/utils/oauth_token_manager.dart';
import '../../kakao/main_view_model.dart';
import '../../point/component/point_list.dart';

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

    if (email != null) {
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
      } else {
        print('데이터 로드 실패, 상태 코드: ${response.statusCode}');
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
              // top: 10.0,
              left: 40.0,
              right: 40.0,
              bottom: 2.0,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.25,
            margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
            padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
              color: BACK_COLOR,
              border: Border.all(
                color: PRIMARY_COLOR,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Align(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '${myData['nickname'] ?? "회원"} 님 안녕하세요 !',
                              style: TextStyle(fontSize: 22.0),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              widget.mainViewModel.changeTabIndex(0);
                            },
                            child: Image.asset(
                              'assets/image/order.png',
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.mainViewModel.changeTabIndex(0);
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
                              Get.to(() => ReviewScreen(mainViewModel: widget.mainViewModel,)
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
                              Get.to(() => ReviewScreen(mainViewModel: widget.mainViewModel,)
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
                              Get.to(() => JjimScreen(mainViewModel: widget.mainViewModel,)
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
                              Get.to(() => JjimScreen(mainViewModel: widget.mainViewModel,)
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
                ],
              )
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
                      Get.to(() => NicknamePage(mainViewModel: widget.mainViewModel, nickName: myData['nickname'],)
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
          PointList(mainViewModel: widget.mainViewModel,),

          Container(
            padding: const EdgeInsets.only(bottom: 30.0,top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSquareButton(
                    context,
                    '신고',
                        () {
                      Get.to(() => NicknamePage(
                        mainViewModel: widget.mainViewModel, nickName: myData['nickname'],)
                      );
                    }
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                _buildSquareButton(
                    context,
                    '회원탈퇴',
                        () {
                      mypageController.showDialogLogOut(context);
                    }
                ),
              ],
            ),
          ),
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
            color: PRIMARY_COLOR,
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


