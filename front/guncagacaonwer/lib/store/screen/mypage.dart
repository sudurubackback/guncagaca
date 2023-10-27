import 'package:flutter/material.dart';
import 'package:guncagacaonwer/basic/screen/passwordchangepage.dart';

class TextInfo {
  final String text;

  TextInfo(this.text);
}

class MyPageScreen extends StatefulWidget {
  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  String userName = "아비꼬"; // 통신을 통해 불러 올 사용자 이름

  List<TextInfo> textInfoList = [
    TextInfo("정산 예정일"),
    TextInfo("두 번째 줄"),
    TextInfo("누적 판매총액"),
    TextInfo("네 번째 줄"),
    TextInfo("수수료"),
    TextInfo("여섯 번째 줄"),
    TextInfo("실 수령액"),
    TextInfo("여덟 번째 줄"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.centerLeft, // 왼쪽 정렬
              child: Container(
                margin: EdgeInsets.only(left: 50.0),
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "$userName 사장님 환영합니다.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ), // 상단의 텍스트
            SizedBox(
              height: 40,
            ),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 30.0, // 가로 간격 조절
              runSpacing: 1.0, // 세로 간격 조절
              children: textInfoList.map((textInfo) {
                return Container(
                  width: 500, // 원하는 가로 크기로 조정
                  height: 100, // 원하는 세로 크기로 조정
                  child: Center(
                    child: Text(
                      textInfo.text,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(top: 40, right: 60), // 오른쪽에 마진을 줍니다
              alignment: Alignment.centerRight, // 오른쪽 정렬
              child: ElevatedButton(
                onPressed: () {
                  // 비밀번호 변경 화면으로 이동
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        // 비밀번호 변경 화면의 위젯을 반환
                        return PasswordChangePage(); // PasswordChangeScreen은 실제로 비밀번호 변경 화면을 구현한 위젯 클래스입니다.
                      },
                    ),
                  );
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(200, 60)),
                  backgroundColor: MaterialStateProperty.all(Color(0xFFD9D9D9)),
                ),
                child: Text(
                  '비밀번호 변경',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
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
