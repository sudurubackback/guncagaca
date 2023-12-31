import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guncagaca/common/const/colors.dart';


class NotificationPage extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotificationPage> {


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: BACK_COLOR,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0, // 밑 줄 제거
          automaticallyImplyLeading: false, // leading 영역을 자동으로 생성하지 않도록 설정
          flexibleSpace: Center(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 20),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30.0,
                    color: Color(0xff000000),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.26, top: 20.0),
                  child: Row(
                    children: [
                      const Text(
                        '알림함',
                        style: TextStyle(color: Colors.black, fontSize: 29.0),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(width: 10.0), // 이미지와 텍스트 사이 간격 조절
                      Image.asset(
                        'assets/image/noti.png', // 이미지 파일 경로 설정
                        width: 30.0, // 이미지 너비 설정
                        height: 30.0, // 이미지 높이 설정
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: PRIMARY_COLOR,
              height: 2.0,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),

          ],
        ),
      ),
    );
  }

}

