import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:guncagacaonwer/basic/api/resetpw_api_service.dart';
import 'package:guncagacaonwer/basic/models/resetpwmodel.dart';

class PasswordRecoveryPage extends StatefulWidget {
  @override
  _PasswordRecoveryPageState createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  String email = '';

  late ApiService apiService;

  @override
  void initState() {
    super.initState();

    Dio dio = Dio();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    apiService = ApiService(dio);
  }

  TextEditingController emailController = TextEditingController();

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
                  controller: emailController,
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
                      try {
                        final response = await apiService.resetPassword(ResetPasswordRequest(emailController.text));

                        if (response.status == 200) {
                          // 비밀번호 초기화 성공
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('비밀번호 초기화 성공'),
                                content: Text('비밀번호 초기화 메일을 이메일 주소로 전송했습니다.'),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: Text('확인'),
                                    onPressed: () {
                                      Navigator.of(context).pop(); // 다이얼로그 닫기
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          // 비밀번호 초기화 실패
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('비밀번호 초기화 실패'),
                                content: Text('비밀번호 초기화 메일을 보내는 중 문제가 발생했습니다.'),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: Text('확인'),
                                    onPressed: () {
                                      Navigator.of(context).pop(); // 다이얼로그 닫기
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      } catch (e) {
                        // 통신 실패 시 예외 처리
                        print('통신 실패: $e');
                      }
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
