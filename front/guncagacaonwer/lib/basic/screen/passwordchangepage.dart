import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:guncagacaonwer/basic/api/changepw_api_service.dart';
import 'package:guncagacaonwer/store/screen/storepage.dart';

class PasswordChangePage extends StatefulWidget {
  @override
  _PasswordChangePageState createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  String currentPassword = '';
  String newPassword = '';
  String confirmPassword = '';

  late ApiService apiService;

  @override
  void initState() {
    super.initState();

    Dio dio = Dio();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    apiService = ApiService(dio);
  }

  @override
  void dispose() {
    passwordMatchStreamController.close();
    super.dispose();
  }

  TextEditingController passwordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final passwordMatchStreamController = StreamController<bool>.broadcast();

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
          "비밀번호 변경",
          style: TextStyle(fontSize: 12 * (deviceWidth / standardDeviceWidth)),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50 * (deviceHeight / standardDeviceHeight),
                ),
                Container(
                  width: 220 * (deviceWidth / standardDeviceWidth),
                  height: 40 * (deviceHeight / standardDeviceHeight),
                  child : TextFormField(
                    controller: passwordController,
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
                SizedBox(height: 10 * (deviceHeight / standardDeviceHeight)),
                Container(
                  width: 220 * (deviceWidth / standardDeviceWidth),
                  height: 40 * (deviceHeight / standardDeviceHeight),
                  child : TextFormField(
                    controller: newpasswordController,
                    decoration: InputDecoration(
                      labelText: '새 비밀번호',
                      labelStyle: TextStyle(
                        color: Color(0xFF9B5748),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF9B5748)),
                      ),
                    ),
                    onChanged: (_) {
                      checkPasswordMatch();
                    },
                  ),
                ),
                SizedBox(height: 10 * (deviceHeight / standardDeviceHeight)),
                Container(
                  width: 220 * (deviceWidth / standardDeviceWidth),
                  height: 40 * (deviceHeight / standardDeviceHeight),
                  child : TextFormField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: '새 비밀번호 확인',
                      labelStyle: TextStyle(
                        color: Color(0xFF9B5748),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF9B5748)),
                      ),
                    ),
                    onChanged: (_) {
                      checkPasswordMatch();
                    },
                  ),
                ),
                StreamBuilder<bool>(
                  stream: passwordMatchStreamController.stream,
                  builder: (context, snapshot) {
                    bool passwordsMatch = snapshot.data ?? false;
                    return Text(
                      passwordsMatch ? '비밀번호가 일치합니다.' : '비밀번호가 일치하지 않습니다.',
                      style: TextStyle(
                        color: passwordsMatch ? Colors.green : Colors.red,
                      ),
                    );
                  },
                ),
                SizedBox(height: 10 * (deviceHeight / standardDeviceHeight)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // 가로로 공간을 동일하게 배분
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // 현재 화면을 종료하고 이전 화면으로 돌아갑니다.
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(
                            70 * (deviceWidth / standardDeviceWidth),
                            25 * (deviceHeight / standardDeviceHeight))),
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
                          fontSize: 12 * (deviceWidth / standardDeviceWidth),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => StorePage(),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(
                            70 * (deviceWidth / standardDeviceWidth),
                            25 * (deviceHeight / standardDeviceHeight))),
                        backgroundColor: MaterialStateProperty.all(Color(0xFF9B5748).withOpacity(0.5)),
                      ),
                      child: Text(
                        '확인',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12 * (deviceWidth / standardDeviceWidth),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkPasswordMatch() {
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    bool passwordsMatch = password == confirmPassword;
    passwordMatchStreamController.sink.add(passwordsMatch);
  }
}
