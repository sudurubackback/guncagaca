import 'package:flutter/material.dart';
// import 'package:guncagacaonwer/store/screen/storepage.dart';

class PasswordChangePage extends StatefulWidget {
  @override
  _PasswordChangePageState createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  String currentPassword = '';
  String newPassword = '';
  String confirmPassword = '';

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
                    labelText: '현재 비밀번호',
                    labelStyle: TextStyle(
                      color: Color(0xFF9B5748),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF9B5748)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 500,
                height: 100,
                child : TextFormField(
                  decoration: InputDecoration(
                    labelText: '새 비밀번호',
                    labelStyle: TextStyle(
                      color: Color(0xFF9B5748),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF9B5748)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 500,
                height: 100,
                child : TextFormField(
                  decoration: InputDecoration(
                    labelText: '새 비밀번호 확인',
                    labelStyle: TextStyle(
                      color: Color(0xFF9B5748),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF9B5748)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // 가로로 공간을 동일하게 배분
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
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(
                      //     builder: (context) => StorePage(),
                      //   ),
                      // );
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(200, 80)),
                      backgroundColor: MaterialStateProperty.all(Color(0xFF9B5748).withOpacity(0.5)),
                    ),
                    child: Text(
                      '확인',
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
