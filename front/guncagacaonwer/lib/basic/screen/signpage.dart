import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:guncagacaonwer/basic/api/sign_api_service.dart';
import 'package:guncagacaonwer/basic/models/signmodel.dart';
import 'package:guncagacaonwer/basic/screen/storeinforegisterpage.dart';
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

  @override
  void initState() {
    super.initState();

    Dio dio = Dio();
    apiService = ApiService(dio);
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
                Container(
                  width: 250 * (deviceWidth / standardDeviceWidth),
                  height: 50 * (deviceHeight / standardDeviceHeight),
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
                SizedBox(height: 5 * (deviceHeight / standardDeviceHeight)),
                Container(
                  width: 250 * (deviceWidth / standardDeviceWidth),
                  height: 50 * (deviceHeight / standardDeviceHeight),
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
                SizedBox(height: 5 * (deviceHeight / standardDeviceHeight)),
                Container(
                  width: 250 * (deviceWidth / standardDeviceWidth),
                  height: 50 * (deviceHeight / standardDeviceHeight),
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
                SizedBox(height: 5 * (deviceHeight / standardDeviceHeight)),
                ElevatedButton(
                  onPressed: () async {
                    // try {
                    //   // 요청 데이터 모델
                    //   final signUpRequest = SignUpRequest(email, password, tel);
                    //
                    //   // API 서비스 사용해 회원가입 요청
                    //   final response = await apiService.signupUser(signUpRequest);
                    //
                    //   // 응답 처리
                    //   if (response.status == 0) {
                    //     // 회원가입 성공 -> 가게 정보 등록 창으로 이동
                    //     Navigator.of(context).pushReplacement(
                    //       MaterialPageRoute(
                    //         builder: (context) => StoreInfoRegisterPage(),
                    //       ),
                    //     );
                    //   } else {
                    //     // 회원가입 실패
                    //     // 실패 이유에 따라 사용자에게 메시지를 표시하거나 로깅할 수 있습니다.
                    //     showDialog(
                    //       context: context,
                    //       builder: (context) {
                    //         return AlertDialog(
                    //           title: Text('회원가입 실패'),
                    //           content: Text('회원가입에 실패했습니다. 다시 시도해 주세요.'),
                    //           actions: <Widget>[
                    //             ElevatedButton(
                    //               child: Text('확인'),
                    //               onPressed: () {
                    //                 Navigator.of(context).pop(); // 다이얼로그 닫기
                    //               },
                    //             ),
                    //           ],
                    //         );
                    //       },
                    //     );
                    //   }
                    // } catch (e) {
                    //   // 통신 실패 시 예외 처리
                    //   print('통신 실패 : $e');
                    // }
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => StoreInfoRegisterPage(),
                      ),
                    );
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
