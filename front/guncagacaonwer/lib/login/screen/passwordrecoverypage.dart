import 'package:flutter/material.dart';

class PasswordRecoveryPage extends StatefulWidget {
  @override
  _PasswordRecoveryPageState createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9B5748),
        title: Text(
          "근카가카",
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
                margin: EdgeInsets.only(right: 350, bottom: 50),
                child: Text(
                  "비밀번호 찾기",
                  style: TextStyle(
                    fontSize: 30, // 원하는 폰트 크기로 설정
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 500,
                height: 100,
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
                      minimumSize: MaterialStateProperty.all(Size(200, 80)),
                      backgroundColor: MaterialStateProperty.all(Color(0xFFFFFFFF)),
                      side: MaterialStateProperty.all(BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      )),
                    ),
                    child: Text(
                      '취소',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
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
                      minimumSize: MaterialStateProperty.all(Size(200, 80)),
                      backgroundColor: MaterialStateProperty.all(Color(0xFF9B5748).withOpacity(0.5)),
                    ),
                    child: Text(
                      '찾기',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
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
