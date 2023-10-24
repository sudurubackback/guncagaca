import 'package:flutter/material.dart';

class SignPage extends StatefulWidget {

  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  String email = '';
  String password = '';
  String tel = '';

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
                width: 500,
                height: 100,
                child : TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Color(0xFF9B5748),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF9B5748)),
                    ),
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 500,
                height: 100,
                child : TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Color(0xFF9B5748),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF9B5748)),
                    ),
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 500,
                height: 100,
                child : TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Tel',
                    labelStyle: TextStyle(
                      color: Color(0xFF9B5748),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF9B5748)),
                    ),
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                ),
              ),
              SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // 회원가입 로직 추가
                    // 이메일, 비밀번호, 닉네임을 사용하여 회원가입 처리
                  },
                  style: ButtonStyle(
                    // 버튼의 최소 크기 설정
                    minimumSize: MaterialStateProperty.all(Size(400, 60)), // 가로 150, 세로 50

                    // 버튼의 배경 색상 설정
                    backgroundColor: MaterialStateProperty.all(Color(0xFF9B5748).withOpacity(0.5)), // 배경 색상
                  ),
                  child: Text(
                    '회원가입',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,// 텍스트 색상
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
