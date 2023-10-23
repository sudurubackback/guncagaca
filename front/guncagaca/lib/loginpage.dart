import 'package:flutter/material.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _onKakaoButtonPressed() {
    print('버튼 클릭 완료');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  Widget _buildTitleText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildSubText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 40),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildKakaoButton() {
    return GestureDetector(
      onTap: _onKakaoButtonPressed,
      child: Image.asset('assets/image/kakao_button.png'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Container(
          color: Color(0xfff8e9d7),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTitleText("근카가카"),
                _buildSubText("근처카페 x 가까운 카페"),
                _buildKakaoButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
