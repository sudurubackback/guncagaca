import 'package:flutter/material.dart';

class PasswordRecoveryPage extends StatefulWidget {
  @override
  _PasswordRecoveryPageState createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  String email = '';

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardDeviceWidth = 500;
    final standardDeviceHeight = 350;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9B5748),
        title: Text(
          "비밀번호 찾기",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  "이메일을 입력하시면 초기화된 비밀번호가 이메일로 전송됩니다.",
                  style: TextStyle(
                    fontSize: 9 * (deviceWidth / standardDeviceWidth), // 원하는 폰트 크기로 설정
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 250 * (deviceWidth / standardDeviceWidth),
                height: 50 * (deviceHeight / standardDeviceHeight),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: '이메일',
                    labelStyle: TextStyle(
                      color: Color(0xFF9B5748),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF9B5748)),
                    ),
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // 현재 화면을 종료하고 이전 화면으로 돌아갑니다.
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(
                          60 * (deviceWidth / standardDeviceWidth),
                          40 * (deviceHeight / standardDeviceHeight))),
                      backgroundColor: MaterialStateProperty.all(Color(0xFFFFFFFF)),
                      side: MaterialStateProperty.all(BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      )),
                    ),
                    child: Text(
                      '취소',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15 * (deviceWidth / standardDeviceWidth),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // 이메일을 사용하여 비밀번호 초기화 메일을 보내는 로직을 추가
                      // 비밀번호 초기화 메일을 보낸 후 사용자에게 알림을 표시할 수 있습니다.
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(
                          60 * (deviceWidth / standardDeviceWidth),
                          40 * (deviceHeight / standardDeviceHeight))),
                      backgroundColor: MaterialStateProperty.all(Color(0xFF9B5748).withOpacity(0.5)),
                    ),
                    child: Text(
                      '찾기',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15 * (deviceWidth / standardDeviceWidth),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
