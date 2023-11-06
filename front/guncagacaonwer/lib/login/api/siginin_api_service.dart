import 'package:dio/dio.dart';
import 'package:guncagacaonwer/login/api/siginin__api.dart';
import 'package:guncagacaonwer/login/models/sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignInApiService {
  static final storage = FlutterSecureStorage(); // FlutterSecureStorage를 storage로 저장
  static final BaseOptions options = BaseOptions(
    baseUrl: Api.BASE_URL,
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 3),
  );

  late final Dio dio;

  SignInApiService() {
    dio = Dio(options);
  }

  Future<bool> signin(String email, String password) async {

    var data = {
      'email': email,
      'password': password,
    };

    try {
      Response response = await dio.post(Api.LOGIN_URL, data: data);

      if (response.statusCode == 200) {
        TokenResult tokenResult = TokenResult.fromJson(response.data);

        await saveToken(tokenResult);

        return true;
      }
      return false;
    } catch (error) {
      print('API 호출 중 오류 발생: $error');
      return false;
    }
  }

  Future<bool> refresh() async {
    //header에 refreshtoken을 넣어서 보냄
    String? refreshToken = await storage.read(key: 'refreshToken');

    dio.options.headers['Authorization'] = 'Bearer $refreshToken';

    try{
      Response response = await dio.post(Api.REFRESH_URL);

      if (response.statusCode == 200) {
        // 성공한 경우
        TokenResult tokenResult = TokenResult.fromJson(response.data);
        await saveToken(tokenResult);
        return true;
      } else {
        // 실패한 경우
        return false;
      }
    }
    catch(error){
      return false;
    }

  }

  Future<void> saveToken(TokenResult tokenResult) async {
    storage.write(key: 'accessToken', value: tokenResult.accessToken);
    storage.write(key: 'refreshToken', value: tokenResult.refreshToken);
  }

}