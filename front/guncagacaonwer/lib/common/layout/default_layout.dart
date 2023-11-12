import 'package:flutter/material.dart';
import 'package:guncagacaonwer/common/const/colors.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? customAppBarBottom;

  DefaultLayout({required this.child, this.customAppBarBottom});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardDeviceWidth = 500;
    final standardDeviceHeight = 350;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.08 * (deviceHeight / standardDeviceHeight),
        backgroundColor: BACK_COLOR,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/main.png', // 이미지 경로를 지정해야 합니다.
                width: MediaQuery.of(context).size.width * 0.1, // 이미지의 너비 조절
                height: MediaQuery.of(context).size.height * 0.1, // 이미지의 높이 조절
              ),
            ),

            Text(
              "근카가카",
              style: TextStyle(fontSize: 30, color: Color(0xff1C386D)),
            ),

          ],
        ),
        bottom: customAppBarBottom,
        automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset: false,
      body: child,
    );
  }
}
