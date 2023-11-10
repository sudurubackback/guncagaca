
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:guncagaca/common/layout/default_layout.dart';
import 'package:guncagaca/common/view/root_tab.dart';
import 'package:guncagaca/kakao/kakao_login.dart';
import 'package:guncagaca/kakao/main_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/utils/dio_client.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final mainViewModel = MainViewModel(KakaoLogin());
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences().then((_) {
      _tryAutoLogin();
    });
  }

  String baseUrl = dotenv.env['BASE_URL']!;
  Dio dio = DioClient.getInstance();

  // SharedPreferences 초기화
  Future<void> _initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  //자동 로그인 시도
  void _tryAutoLogin() {
    final accessToken = prefs.getString('accessToken');
    final refreshToken = prefs.getString('refreshToken');
    print(accessToken);
    if (accessToken != null && refreshToken != null) {
      // 저장된 토큰을 사용해 로그인 시도
      // 예: 서버로 토큰을 보내 인증 수행
      // 인증이 성공하면 홈 화면으로 이동
      // 실패하면 로그인 화면으로 유지
      Get.to(() => DefaultLayout(
            child: RootTab(mainViewModel: mainViewModel,),
            mainViewModel: mainViewModel,
        )
      );
    }
  }

  void _onKakaoButtonPressed() async {
    await mainViewModel.login();
    if (mainViewModel.isLogined) {
      final nickname = mainViewModel.user?.kakaoAccount?.profile?.nickname;
      final email = mainViewModel.user?.kakaoAccount?.email;
      print('버튼 클릭 완료');
      final tokens = await _fetchTokens(nickname, email);
      print(tokens);
      if (tokens != null) {
        // 토큰들을 얻었을 경우, 저장하고 다음 화면으로 이동
        // tokens['access'] 및 tokens['refresh']를 SharedPreference에 저장
        // 저장 후 홈 화면으로 이동
        print('Access Token: ${tokens['accessToken']}');
        print('Refresh Token: ${tokens['refreshToken']}');
        prefs.setString('accessToken', tokens['accessToken']);
        prefs.setString('refreshToken', tokens['refreshToken']);

        Get.to(() => DefaultLayout(
          child: RootTab(mainViewModel: mainViewModel,),
          mainViewModel: mainViewModel,
        ));
      } else {
        print('토큰 얻기 실패');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DefaultLayout(
            child: RootTab(mainViewModel: mainViewModel,),
            mainViewModel: mainViewModel,
          )),
        );
      }
    } else {
      print('로그인 실패');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DefaultLayout(
          child: RootTab(mainViewModel: mainViewModel,),
          mainViewModel: mainViewModel,
        )),
      );
    }
  }

  Future<Map<String, dynamic>?> _fetchTokens(String? nickname, String? email) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? firebaseToken = await messaging.getToken();
    print("로그인 fcm토큰 : $firebaseToken");
    final String apiUrl = "$baseUrl/api/member/sign";

    final response = await dio.post(
        apiUrl,
        options: Options(
            headers: {
              'Content-Type': 'application/json',
            }
        ),
        data: {
          'nickname': nickname,
          'email': email,
          'fcmToken' : firebaseToken,
        }
    );

    if (response.statusCode == 200) {
      print(response.data);
      final Map<String, dynamic> tokens = response.data;
      return tokens;
    } else {
      return null;
    }
  }

  Widget _buildTitleText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildSubText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 40),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildKakaoButton() {
    return GestureDetector(
      onTap: _onKakaoButtonPressed,
      child: Image.asset('assets/image/kakao_button.png'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Container(
          color: Color(0xfff8e9d7),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTitleText("근카가카"),
                _buildSubText("근처카페 x 가까운 카페"),
                _buildKakaoButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
