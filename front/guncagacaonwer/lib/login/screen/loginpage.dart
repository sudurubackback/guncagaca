
import 'package:flutter/material.dart';
import 'package:guncagacaonwer/login/api/siginin_api_service.dart';
import 'package:guncagacaonwer/store/screen/storepage.dart';
import 'package:guncagacaonwer/basic/screen/passwordrecoverypage.dart';
import 'package:guncagacaonwer/basic/screen/signpage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final SignInApiService apiService = SignInApiService();

  // 자동로그인 구현
  @override
  void initState() {
    super.initState();

    _checkStorage();
  }

  void _checkStorage() async {
    print("자동 로그인 시도했음");
    String? refreshToken = await storage.read(key: 'refreshToken');
    bool? autoLoginValue = (await storage.read(key: 'autoLogin')) == 'true';

    print(refreshToken);

    if (autoLoginValue != null && autoLoginValue == true && refreshToken != null && refreshToken.isNotEmpty) {
      bool result = await apiService.refresh();
      if (result) {
        print('자동 로그인 성공');
        toggleLoginState();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => StorePage(),
        ));
      } else {
        print('자동 로그인 실패');
      }
    }
  }


  var email = TextEditingController();
  var password = TextEditingController();

  static final storage = FlutterSecureStorage(); // FlutterSecureStorage를 storage로 저장

  Color mainColor = Color(0xFF9B5748);
  bool loginState = false;

  void toggleLoginState() {
    setState(() {
      loginState = !loginState;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 이미지가 화면 상단 중앙에 배치됨
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: <Widget>[
                  Image.asset('assets/geuncagaca.png', width: 400, height: 200,),
                ],
              ),
              SizedBox(height: 10,),
              Column(
                children: <Widget>[
                  Container(
                    width: 400,
                    height: 70,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          mainColor = Color(0xFF9B5748);
                          mainColor = Color(0xFF9B5748);
                        });
                      },
                      child: TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: mainColor,
                          ),

                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: mainColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    width: 400,
                    height: 70,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          mainColor = Color(0xFF9B5748);
                          mainColor = Color(0xFF9B5748);
                        });
                      },
                      child: TextFormField(
                        obscureText: true,
                        controller: password,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: mainColor,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: mainColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 428), // 왼쪽 여백 조절
                      Container(
                        child: InkWell(
                          onTap: () {
                            toggleLoginState();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: loginState ? Colors.black : Colors.white,
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: loginState
                                    ? Icon(Icons.check, color: Colors.white)
                                    : Container(),
                              ),
                              SizedBox(width: 8),
                              Text(loginState ? '로그인 상태 유지' : '로그인 상태 유지'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      bool result = await apiService.signin(email.text, password.text);
                      await storage.write(key: 'autoLogin', value: loginState ? 'true' : 'false');

                      if(result == false) {
                        return;
                      }
                      toggleLoginState();

                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => StorePage(),
                      ));
                    },
                    style: ButtonStyle(
                      // 버튼의 최소 크기 설정
                      minimumSize: MaterialStateProperty.all(Size(400, 60)), // 가로 150, 세로 50

                      // 버튼의 배경 색상 설정
                      backgroundColor: MaterialStateProperty.all(Color(0xFF9B5748).withOpacity(0.5)), // 배경 색상
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,// 텍스트 색상
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0), // 로그인 버튼과 추가 요소 사이 간격 조절
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          // 회원가입 링크를 눌렀을 때의 동작
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SignPage(),
                              )
                          );
                        },
                        child: Text(
                          '회원가입',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 240), // 간격 조정
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PasswordRecoveryPage(),
                              )
                          );
                        },
                        child: Text(
                          '비밀번호 찾기',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
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
