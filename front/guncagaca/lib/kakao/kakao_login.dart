import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_login/social_login.dart';

class KakaoLogin implements SocialLogin {
  @override
  Future<bool> login() async{
    try {
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
          print(await KakaoSdk.origin);
          await UserApi.instance.loginWithKakaoAccount();
          return true;
        } catch (e) {
          print("login with kakao Account fail");
          print(e);
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