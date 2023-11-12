
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