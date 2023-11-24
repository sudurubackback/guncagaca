import 'package:guncagaca/kakao/social_login.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';


class KakaoLogin implements SocialLogin {
  @override
  Future<bool> login() async{
    try {
      print("해시");
      print(await KakaoSdk.origin);
      bool isInstalled = await isKakaoTalkInstalled();
      if (isInstalled) {
        try {
          await UserApi.instance.loginWithKakaoTalk();
          return true;
        } catch (e) {
          return false;
        }
      } else {
        print("no installed");
        try {
          await UserApi.instance.loginWithKakaoAccount();
          return true;
        } catch (e) {
          print("login with kakao Account fail $e");
          return false;
        }

      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await UserApi.instance.unlink();
      return true;
    } catch (e) {
      return false;
    }
  }
}