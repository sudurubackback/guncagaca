import 'package:flutter/material.dart';

import '../../kakao/main_view_model.dart';
import '../../login/loginpage.dart';

class MypageController {

  final MainViewModel mainViewModel;

  MypageController({required this.mainViewModel});


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
              mainAxisAlignment: MainAxisAlignment.center,
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
                SizedBox(width: 30),
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