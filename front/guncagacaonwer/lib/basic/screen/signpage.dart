import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:guncagacaonwer/basic/api/sign_api_service.dart';
import 'package:guncagacaonwer/basic/models/checkcodemodel.dart';
import 'package:guncagacaonwer/basic/models/emailvalidationmodel.dart';
import 'package:guncagacaonwer/basic/models/sendcodemodel.dart';
import 'package:guncagacaonwer/basic/models/signmodel.dart';
import '../../login/screen/loginpage.dart';

class SignPage extends StatefulWidget {

  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  String email = '';
  String password = '';
  String tel = '';

  late ApiService apiService;
  EmailValidationResponse? response;

  @override
  void initState() {
    super.initState();

    Dio dio = Dio();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    apiService = ApiService(dio);
  }

  bool showSecondRow = false;
  bool isCodeVerified = false; // 인증 코드가 확인되었는지 여부
  String validationMessage = "";
  String failureMessage = "";
  TextEditingController codeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController(); // 비밀번호 입력 필드를 위한 컨트롤러
  TextEditingController telController = TextEditingController(); // 전화번호 입력 필드를 위한 컨트롤러

  Timer? emailValidationTimer;

  // 이메일 유효성 인증
  void validateEmail(String email) {
    if (email.isEmpty) {
      setState(() {
        validationMessage = "";
      });
      return;
    }
    // 이메일 유효성을 검사하려면 1초 후에 API를 호출
    if (emailValidationTimer != null && emailValidationTimer!.isActive) {
      // 이미 타이머가 활성화 중이라면 이전 타이머를 취소
      emailValidationTimer!.cancel();
    }

    emailValidationTimer = Timer(const Duration(seconds: 1), () {
      // 1초 후에 API 요청 실행
      callEmailValidationApi(emailController.text);
    });
  }

  void callEmailValidationApi(String email) async {
    try {
      final emailResponse = await apiService.emailValidation(EmailValidationRequest(email));
      setState(() {
        response = emailResponse;
      });
      if (emailResponse.status == 200) {
        setState(() {
          validationMessage = "유효한 이메일입니다.";
          print(validationMessage);
        });
      } else {
        setState(() {
          validationMessage = "유효하지 않은 이메일입니다.";
          print(validationMessage);
        });
      }
    } catch (e) {
      print("에러: $e");
    }
  }

  // 이메일 인증 요청
  void sendCode(String email) async {
    try {
      final response = await apiService.sendCode(SendCodeRequest(email));

      if (response.status == 200) {
        // 인증 코드 전송 성공
        // 이에 대한 UI나 처리를 추가하세요
      } else {
        // 인증 코드 전송 실패
        // 이에 대한 UI나 처리를 추가하세요
      }
    } catch (e) {
      print("에러: $e");
    }
  }

  // 인증 코드 확인 요청
  void checkCode(String email, String code) async {
    try {
      final response = await apiService.checkCode(CheckCodeRequest(email, code));

      if (response.status == 200) {
        // 인증 코드 확인 성공
        isCodeVerified = true;
        // 사용자에게 알림 메시지 표시 또는 필요한 동작 수행
      } else {
        // 인증 코드 확인 실패
        failureMessage = "인증 코드가 올바르지 않습니다. 다시 입력해 주세요.";
        // 사용자에게 실패 메시지 표시 또는 필요한 동작 수행
      }
    } catch (e) {
      print("에러: $e");
    }
  }

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
          "회원가입",
          style: TextStyle(fontSize: 30),
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
                  height: 40 * (deviceHeight / standardDeviceHeight),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 25 * (deviceWidth / standardDeviceWidth),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 250 * (deviceWidth / standardDeviceWidth),
                          height: 30 * (deviceHeight / standardDeviceHeight),
                          child: TextFormField(
                            controller: emailController,
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
                              validateEmail(value);
                            },
                          ),
                        ),
                        Text(
                          validationMessage,
                          style: TextStyle(
                            color: response?.status == 200 ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 2 * (deviceWidth / standardDeviceWidth)),
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          // 이메일이 유효한 경우에만 인증 코드 요청을 보내도록 변경
                          if (validationMessage == "유효한 이메일입니다.") {
                            sendCode(emailController.text); // 이메일로 인증 코드 요청 보내기
                            showSecondRow = true;
                          }
                          // 인증 요청 버튼을 누르면 두 번째 로우를 보이게 함
                          // showSecondRow = true;
                        });
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          Size(
                            10 * (deviceWidth / standardDeviceWidth),
                            30 * (deviceHeight / standardDeviceHeight),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xFF828282),
                        ),
                      ),
                      child: Text(
                        '인증\n요청',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 7 * (deviceWidth / standardDeviceWidth),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1 * (deviceHeight / standardDeviceHeight)),
                Visibility(
                  visible: showSecondRow,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 100 * (deviceWidth / standardDeviceWidth),
                        height: 20 * (deviceHeight / standardDeviceHeight),
                        child: TextFormField(
                          controller: codeController,
                          decoration: InputDecoration(
                            labelText: '인증 코드',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            filled: true,
                            fillColor: isCodeVerified ? Colors.grey : Colors.white, // 배경색 설정
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                            contentPadding: EdgeInsets.only(
                                top: 1 * (deviceHeight / standardDeviceHeight),
                                left: 4 * (deviceWidth / standardDeviceWidth)
                            ),
                          ),
                          style: TextStyle(fontSize: 8 * (deviceWidth / standardDeviceWidth)),
                          enabled: !isCodeVerified,
                        ),
                      ),
                      Text(
                        failureMessage,  // 실패 메시지를 표시
                        style: TextStyle(
                          color: Colors.red, // 실패 메시지의 색상을 빨간색으로 설정
                        ),
                      ),
                      SizedBox(width: 2 * (deviceWidth / standardDeviceWidth)),
                      ElevatedButton(
                        onPressed: () async {
                          // 새로운 필드 버튼을 누를 때의 동작
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            Size(
                              10 * (deviceWidth / standardDeviceWidth), // 같은 너비로 조절
                              20 * (deviceHeight / standardDeviceHeight), // 같은 높이로 조절
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(Color(0xFF828282)), // 회색 배경색
                        ),
                        child: Text('재요청', style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 2 * (deviceWidth / standardDeviceWidth)),
                      ElevatedButton(
                        onPressed: () async {
                          checkCode(emailController.text, codeController.text); // 이메일과 인증 코드를 확인합니다.
                          setState(() {
                            isCodeVerified = true;
                          });
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            Size(
                              10 * (deviceWidth / standardDeviceWidth), // 같은 너비로 조절
                              20 * (deviceHeight / standardDeviceHeight), // 같은 높이로 조절
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(Color(0xFF406AD6)), // 파란색 배경색
                        ),
                        child: Text('확인', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3 * (deviceHeight / standardDeviceHeight)),
                Container(
                  width: 250 * (deviceWidth / standardDeviceWidth),
                  height: 50 * (deviceHeight / standardDeviceHeight),
                  child : TextFormField(
                    controller: passwordController,
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
                SizedBox(height: 3 * (deviceHeight / standardDeviceHeight)),
                Container(
                  width: 250 * (deviceWidth / standardDeviceWidth),
                  height: 50 * (deviceHeight / standardDeviceHeight),
                  child : TextFormField(
                    controller: telController,
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
                      tel = value;
                    },
                  ),
                ),
                SizedBox(height: 5 * (deviceHeight / standardDeviceHeight)),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      // 요청 데이터 모델
                      final signUpRequest = SignUpRequest(emailController.text, passwordController.text, telController.text, 0);

                      // API 서비스 사용해 회원가입 요청
                      final response = await apiService.signupUser(signUpRequest);

                      // 응답 처리
                      if (response.status == 200) {
                        // 회원가입 성공 -> 가게 정보 등록 창으로 이동
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      } else {
                        // 회원가입 실패
                        // 실패 이유에 따라 사용자에게 메시지를 표시하거나 로깅할 수 있습니다.
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('회원가입 실패'),
                              content: Text('회원가입에 실패했습니다. 다시 시도해 주세요.'),
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
                      print('통신 실패 : $e');
                    }
                    // Navigator.of(context).pushReplacement(
                    //   MaterialPageRoute(
                    //     builder: (context) => LoginPage(),
                    //   ),
                    // );
                  },
                  style: ButtonStyle(
                    // 버튼의 최소 크기 설정
                    minimumSize: MaterialStateProperty.all(
                        Size(
                          180 * (deviceWidth / standardDeviceWidth),
                          30 * (deviceHeight / standardDeviceHeight))), // 가로 150, 세로 50

                    // 버튼의 배경 색상 설정
                    backgroundColor: MaterialStateProperty.all(Color(0xFF9B5748).withOpacity(0.5)), // 배경 색상
                  ),
                  child: Text(
                    '회원가입',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15 * (deviceWidth / standardDeviceWidth),// 텍스트 색상
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
