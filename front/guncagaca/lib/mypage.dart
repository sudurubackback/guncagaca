import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'order.dart';

class Mypage extends StatefulWidget {
  @override
  _MypageState createState() => _MypageState();
}

class _MypageState extends State<Mypage> {

  // 회원 탈퇴
  Future<void> _showDialogOut(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          contentPadding: EdgeInsets.all(20.0),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.2,
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Color(0xff9B5748),
                  ),
                  child: Text('확인', style: TextStyle(color: Color(0xffffffff))),
                  onPressed: () {
                    // 여기에 로그아웃 로직을 추가할 수 있습니다.
                    print("로그아웃 완료");
                    // ...
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width: 30), // 버튼 사이 간격 조절
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
  Future<void> _showDialogLogOut(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          contentPadding: EdgeInsets.all(20.0),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.2,
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Color(0xff9B5748),
                  ),
                  child: Text('확인', style: TextStyle(color: Color(0xffffffff))),
                  onPressed: () {
                    // 여기에 로그아웃 로직을 추가할 수 있습니다.
                    print("로그아웃 완료");
                    // ...
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width: 30), // 버튼 사이 간격 조절
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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




  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Color(0xfff8e9d7),
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: null,
      body:SingleChildScrollView(
        child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 70.0, left: 40.0, right: 40.0, bottom: 30.0), // 위 아래 간격 조정
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    '000님 안녕하세요',
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
                            MaterialPageRoute(builder: (context) => OrderPage()), // OrderPage()는 order.dart 파일에서 가져오는 클래스명입니다. 실제 클래스명으로 대체해주세요.
                          );
                        },
                        child: Image.asset(
                          'assets/image/order.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OrderPage()),
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
                      Image.asset(
                        'assets/image/review.png',
                        width: 80,
                        height: 80,
                      ),
                      const Text(
                        '리뷰',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 위 아래 간격 조정
                    children: [
                      Image.asset(
                        'assets/image/jjim.png',
                        width: 80,
                        height: 80,
                      ),
                      const Text(
                        '나의 찜',
                        style: TextStyle(fontSize: 20.0),
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
                _showDialogLogOut(context);
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
                _showDialogOut(context);
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
    ),
    );
  }

}

