import 'package:flutter/material.dart';
import 'package:guncagaca/jjim/view/jjim_screen.dart';
import 'package:guncagaca/mypage/nickname.dart';
import 'package:guncagaca/mypage/passwordchange.dart';
import 'package:guncagaca/myreview/view/review_screen.dart';
import 'package:guncagaca/orderStatus/order_page.dart';

import '../../kakao/main_view_model.dart';
import '../../point/view/point_screen.dart';

class MypageComponent extends StatelessWidget {
  final MainViewModel mainViewModel;

  final Function onOrderTap;
  final Function onReviewTap;
  final Function onJjimTap;
  final Function onPointTap;
  final Function onNicknameTap;
  final Function onPasswordTap;
  final Function onLogoutTap;
  final Function onWithdrawalTap;
  final Function showDialogLogOut;
  final Function showOut;


  MypageComponent({
    required this.onOrderTap,
    required this.onReviewTap,
    required this.onJjimTap,
    required this.onPointTap,
    required this.onNicknameTap,
    required this.onPasswordTap,
    required this.onLogoutTap,
    required this.onWithdrawalTap,
    required this.showDialogLogOut,
    required this.showOut,
    required this.mainViewModel
  });


  @override
  Widget build(BuildContext context) {
    String? nickname = mainViewModel.user?.kakaoAccount?.profile?.nickname;


    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(
              top: 10.0,
              left: 40.0,
              right: 40.0,
              bottom: 10.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${nickname ?? "회원"} 님 안녕하세요',
                    style: TextStyle(fontSize: 29.0),
                    textAlign: TextAlign.left,
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
                  color: Colors.black.withOpacity(0.2), // 그림자 색상 및 투명도 조절
                  spreadRadius: 0, // 그림자 크기 조절
                  blurRadius: 10, // 그림자 흐릿함 정도 조절
                  offset: Offset(0, 5), // 그림자 위치 조절
                ),
              ],
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 위 아래 간격 조정
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OrderPage(mainViewModel: mainViewModel,)), // OrderPage()는 order.dart 파일에서 가져오는 클래스명입니다. 실제 클래스명으로 대체해주세요.
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
                            MaterialPageRoute(builder: (context) => OrderPage(mainViewModel: mainViewModel,)),
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 위 아래 간격 조정
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ReviewScreen(mainViewModel: mainViewModel,)), // OrderPage()는 order.dart 파일에서 가져오는 클래스명입니다. 실제 클래스명으로 대체해주세요.
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
                            MaterialPageRoute(builder: (context) => ReviewScreen(mainViewModel: mainViewModel,)),
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 위 아래 간격 조정
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => JjimScreen(mainViewModel: mainViewModel,)), // OrderPage()는 order.dart 파일에서 가져오는 클래스명입니다. 실제 클래스명으로 대체해주세요.
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
                            MaterialPageRoute(builder: (context) => JjimScreen(mainViewModel: mainViewModel,)),
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
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.08,
            padding: EdgeInsets.only(left: 30.0, right: 50.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xff9B5748),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PointScreen(mainViewModel: mainViewModel,)), // PasswordChangePage로 이동
                );
              },
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '포인트',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '>',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),

              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.08,
            padding: const EdgeInsets.only(left: 30.0, right: 50.0),
            margin: const EdgeInsets.only(top: 20.0,),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xff9B5748),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NicknamePage(mainViewModel: mainViewModel,)), // PasswordChangePage로 이동
                );
              },
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '닉네임 변경',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '>',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),

              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.08,
            padding: const EdgeInsets.only(left: 30.0, right: 50.0),
            margin: const EdgeInsets.only(top: 20.0,),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xff9B5748),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PasswordPage(mainViewModel: mainViewModel,)), // PasswordChangePage로 이동
                );
              },
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '비밀번호 변경',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '>',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),

              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.08,
            padding: const EdgeInsets.only(left: 30.0, right: 50.0),
            margin: const EdgeInsets.only(top: 20.0,),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xff9B5748),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: InkWell(
              onTap: () {
                showDialogLogOut(context);
              },
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '로그아웃',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '>',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.08,
            padding: const EdgeInsets.only(left: 30.0, right: 50.0),
            margin: const EdgeInsets.only(top: 20.0,),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xff9B5748),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: InkWell(
              onTap: () {
                showOut(context);
              },
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '회원탈퇴',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '>',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }

}
