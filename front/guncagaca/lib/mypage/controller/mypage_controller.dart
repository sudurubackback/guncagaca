import 'package:flutter/material.dart';

import '../../kakao/main_view_model.dart';
import '../../login/loginpage.dart';

class MypageController {

  final MainViewModel mainViewModel;

  MypageController({required this.mainViewModel});

  // 회원 탈퇴
  Future<void> showOut(BuildContext context) async {
    return showDialog<void>(
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
                      '회원탈퇴 하시겠습니까?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Image.asset(
                      'assets/image/close.png',
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
              mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Color(0xff9B5748),
                  ),
                  child: Text('확인', style: TextStyle(color: Color(0xffffffff))),
                  onPressed: () {
                    // 여기에 회원탈퇴 로직을 추가할 수 있습니다.
                    print("회원탈퇴 완료");
                    // ...
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width: 30), // 버튼 사이 간격 조절
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Color(0xff9B5748),
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

  // 로그아웃
  Future<void> showDialogLogOut(BuildContext context) async {
    return showDialog<void>(
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
                      '로그아웃 하시겠습니까?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Image.asset(
                      'assets/image/logout.png',
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
              mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Color(0xff9B5748),
                  ),
                  child: Text('확인', style: TextStyle(color: Color(0xffffffff))),
                  onPressed: () async{
                    await mainViewModel.logout();
                    print("로그아웃 완료");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
                SizedBox(width: 30), // 버튼 사이 간격 조절
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Color(0xff9B5748),
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
}