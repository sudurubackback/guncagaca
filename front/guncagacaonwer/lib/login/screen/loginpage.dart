
import 'package:flutter/material.dart';
import 'package:guncagacaonwer/login/api/siginin_api_service.dart';
import 'package:guncagacaonwer/order/screen/orderpage.dart';
import 'package:guncagacaonwer/store/screen/storepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

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


    final prefs = await SharedPreferences.getInstance();
    String? refreshToken = prefs.getString('refreshToken');
    bool? autoLoginValue = prefs.getBool('autoLogin')=='true';
    // Navigator.of(context).pushReplacement(MaterialPageRoute(
    //   builder: (context) => StorePage(),
    // ));

    // print(refreshToken);

    if (autoLoginValue != null && autoLoginValue == true && refreshToken != null && refreshToken.isNotEmpty) {
      bool result = await apiService.refresh();
      if (result) {
        print('자동 로그인 성공');
        // print();
        toggleLoginState();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => OrderPage(),
        ));
      } else {
        print('자동 로그인 실패');

      }
    }
  }


  var email = TextEditingController();
  var password = TextEditingController();

  Color mainColor = Color(0xFF9B5748);
  bool loginState = false;

  void toggleLoginState() {
    setState(() {
      loginState = !loginState;
    });
  }



  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardDeviceWidth = 500;
    final standardDeviceHeight = 350;

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
                  Image.asset(
                    'assets/geuncagaca.png',
                    width: 200 * (deviceWidth / standardDeviceWidth),
                    height: 80 * (deviceHeight / standardDeviceHeight)),
                ],
              ),
              SizedBox(height: 7 * (deviceHeight / standardDeviceHeight)),
              Column(
                children: <Widget>[
                  Container(
                    width: 200 * (deviceWidth / standardDeviceWidth),
                    height: 30 * (deviceHeight / standardDeviceHeight),
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
                  SizedBox(height: 7 * (deviceHeight / standardDeviceHeight)),
                  Container(
                    width: 200 * (deviceWidth / standardDeviceWidth),
                    height: 30 * (deviceHeight / standardDeviceHeight),
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
                  SizedBox(height: 12 * (deviceHeight / standardDeviceHeight)),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 140 * (deviceWidth / standardDeviceWidth)), // 왼쪽 여백 조절
                      Container(
                        child: InkWell(
                          onTap: () {
                            toggleLoginState();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                width: 10 * (deviceWidth / standardDeviceWidth),
                                height: 12 * (deviceHeight / standardDeviceHeight),
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
                  SizedBox(height: 12 * (deviceHeight / standardDeviceHeight)),
                  ElevatedButton(
                    onPressed: () async {
                      bool result = await apiService.signin(email.text, password.text);

                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('authLogin', loginState);

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
                      minimumSize: MaterialStateProperty.all(Size(200 * (deviceWidth / standardDeviceWidth), 30 * (deviceHeight / standardDeviceHeight))), // 가로 150, 세로 50

                      // 버튼의 배경 색상 설정
                      backgroundColor: MaterialStateProperty.all(Color(0xFF9B5748).withOpacity(0.5)), // 배경 색상
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13 * (deviceWidth / standardDeviceWidth),// 텍스트 색상
                      ),
                    ),
                  ),
                  SizedBox(height: 7 * (deviceHeight / standardDeviceHeight)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
