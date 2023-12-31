import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextInfo {
  final String text;

  TextInfo(this.text);
}

class MyPageScreen extends StatefulWidget {
  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  String userName = "커피비치"; // 통신을 통해 불러 올 사용자 이름

  List<TextInfo> textInfoList = [
    TextInfo("정산 예정일"),
    TextInfo("매주 월, 목"),
    TextInfo("누적 판매총액"),
    TextInfo("102,000 원"),
    TextInfo("수수료"),
    TextInfo("1,530 원"),
    TextInfo("실 수령액"),
    TextInfo("100,470 원"),
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
                    fontSize: 14 * (deviceWidth / standardDeviceWidth),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ), // 상단의 텍스트
            SizedBox(
              height: 25 * (deviceHeight / standardDeviceHeight),
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
          ],
        ),
      ),
    );
  }
}
