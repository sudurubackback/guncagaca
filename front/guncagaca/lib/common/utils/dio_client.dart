import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'oauth_token_manager.dart';

class DioClient {
  static final Dio _dio = Dio();

  static Dio getInstance() {
    // 중복으로 인터셉터가 추가되지 않도록 비우고 새로 추가
    _dio.interceptors.clear();
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          // 요청 전에 해야 할 작업
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          // 응답 후에 해야 할 작업
          return handler.next(response);
        },
        onError: (DioError e, ErrorInterceptorHandler handler) {
          // 에러 발생 시에 해야 할 작업
          print("Error occurred: ${e.message}");

          // 500 에러 발생 시 토큰 갱신 로직
          if (e.response?.statusCode == 500) {
            _refreshToken().then((newToken) {
              if (newToken != null) {
                // 토큰을 성공적으로 갱신했을 때의 로직
                print("재발급");
                TokenManager().setToken(newToken);  // 갱신된 토큰 저장
              }
            }).catchError((error) {
              print("Failed to refresh token: $error");
              // 토큰 갱신 실패
            });
          }
          return handler.next(e);
        },
      ),
    );
    return _dio;
  }


  static Future<String?> getEmailFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }

  static Future<String?> getRefreshTokenFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshToken');
  }

  static Future<String?> _refreshToken() async {
    String? email = await getEmailFromPreferences();
    String? refreshToken = await getRefreshTokenFromPreferences();
    String baseUrl = dotenv.env['BASE_URL']!;

    // 토큰 갱신 API 호출 로직
    try {
      print("토큰 갱신");
      print(email);
      print("$baseUrl/api/member/refresh");
      final response = await _dio.post('$baseUrl/api/member/refresh',
        options: Options(
          headers: {
            'Authorization': 'Bearer $refreshToken',
            'Email': email,
          },
        ),
        // 필요한 파라미터를 여기에 추가
      );
      if (response.statusCode == 200) {
        final newToken = response.data['accessToken'];
        return newToken;
      }
    } catch (error) {
      throw Exception("Failed to refresh token: $error");
    }
    return null;
  }
}
