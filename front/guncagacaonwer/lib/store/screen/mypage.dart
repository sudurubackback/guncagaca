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
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardDeviceWidth = 500;
    final standardDeviceHeight = 350;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10 * (deviceHeight / standardDeviceHeight),
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
              height: 10 * (deviceHeight / standardDeviceHeight),
            ),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 15 * (deviceWidth / standardDeviceWidth), // 가로 간격 조절
              runSpacing: 0.3 * (deviceHeight / standardDeviceHeight), // 세로 간격 조절
              children: textInfoList.map((textInfo) {
                return Container(
                  width: 200 * (deviceWidth / standardDeviceWidth), // 원하는 가로 크기로 조정
                  height: 40 * (deviceHeight / standardDeviceHeight), // 원하는 세로 크기로 조정
                  child: Center(
                    child: Text(
                      textInfo.text,
                      style: TextStyle(
                        fontSize: 11 * (deviceWidth / standardDeviceWidth),
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 15 * (deviceWidth / standardDeviceWidth),
                  right: 30 * (deviceHeight / standardDeviceHeight)), // 오른쪽에 마진을 줍니다
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
                  minimumSize: MaterialStateProperty.all(Size(
                      80 * (deviceWidth / standardDeviceWidth),
                      30 * (deviceHeight / standardDeviceHeight))),
                  backgroundColor: MaterialStateProperty.all(Color(0xFFD9D9D9)),
                ),
                child: Text(
                  '비밀번호 변경',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12 * (deviceWidth / standardDeviceWidth),
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
