import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static final TokenManager _instance = TokenManager._internal();
  late SharedPreferences _prefs;
  String? _token;

  factory TokenManager() {
    return _instance;
  }

  TokenManager._internal();

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    _token = _prefs.getString('accessToken');
  }

  String? get token => _token;

  void setToken(String value) {
    _token = value;
    _prefs.setString('accessToken', value);
  }

  Future<String?> refreshToken() async {
    print("갱신");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? refreshToken = prefs.getString('refreshToken');
    String baseUrl = dotenv.env['BASE_URL']!;

    // 토큰 갱신 API 호출 로직
    try {
      final Dio dio = Dio();
      final response = await dio.post(
        '$baseUrl/api/member/refresh',
        options: Options(
          headers: {
            'Authorization': 'Bearer $refreshToken',
          },
        ),
      );
      if (response.statusCode == 200) {
        final newToken = response.data['accessToken'];
        final newRefreshToken = response.data['refreshToken'];

        // 새 토큰 저장
        prefs.setString('accessToken', newToken);
        prefs.setString('refreshToken', newRefreshToken);
        return newToken;
      }
    } catch (error) {
      throw Exception("Failed to refresh token: $error");
    }
    return null;
  }
}
