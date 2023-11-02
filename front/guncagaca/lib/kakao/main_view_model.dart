import 'dart:math';

import 'package:guncagaca/kakao/social_login.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainViewModel {
  final SocialLogin _socialLogin;
  bool isLogined = false;
  User? user;

  MainViewModel(this._socialLogin);

  Future login() async {
    isLogined = await _socialLogin.login();
    if (isLogined) {
      user = await UserApi.instance.me();
      print(user);

      await _saveEmailToPreferences(user?.kakaoAccount?.email);
    }
    print("Login : " + isLogined.toString());
  }

  Future logout() async {
    await _socialLogin.logout();
    isLogined = false;
    user = null;
  }

  Future<void> _saveEmailToPreferences(String? email) async {
    if (email != null && email.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_email', email);
    }
  }
}