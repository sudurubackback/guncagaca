
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guncagaca/common/view/root_tab.dart';
import 'package:guncagaca/kakao/social_login.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainViewModel {
  final SocialLogin _socialLogin;
  bool isLogined = false;
  User? user;
  RxString currentTitle = '근카가'.obs;
  late Rx<Widget> currentScreen;

  MainViewModel(this._socialLogin) {
    currentScreen = Rx<Widget>(RootTab(mainViewModel: this));
  }

  var tabIndex = 1.obs; //

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  void updateTitle(String newTitle) {
    currentTitle.value = newTitle;
  }

  void updateScreen(Widget newScreen) {
    currentScreen.value = newScreen;
  }

  Future login() async {
    isLogined = await _socialLogin.login();
    if (isLogined) {
      user = await UserApi.instance.me();
      print(user);

      await _saveEmailToPreferences(user?.kakaoAccount?.email);
      await _saveNameToPreferences(user?.kakaoAccount?.name);
    }
    print("Login : " + isLogined.toString());
  }

  Future logout() async {
    await _socialLogin.logout();
    isLogined = false;
    user = null;

    // SharedPreferences에서 토큰 삭제
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');

    // 혹은 토큰을 빈 문자열로 초기화
    // await prefs.setString('accessToken', '');
    // await prefs.setString('refreshToken', '');
  }

  Future<void> _saveEmailToPreferences(String? email) async {
    if (email != null && email.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_email', email);
    }
  }

  Future<void> _saveNameToPreferences(String? name) async {
    if (name != null && name.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', name);
    }
  }
}