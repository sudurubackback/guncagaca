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
        onError: (DioError e, ErrorInterceptorHandler handler) async {
          // 에러 발생 시에 해야 할 작업
          print("Error occurred: ${e.message}");

          // 401, 500 에러 발생 시 토큰 갱신 로직
          if (e.response?.statusCode == 401) {
            final originalRequest = e.requestOptions; // 원래의 요청 저장

            // 재시도 횟수 확인 및 제한
            if (originalRequest.headers.containsKey('retry') &&
                originalRequest.headers['retry'] >= 3) {
              return handler.next(e);
            }

            try {
              final newToken = await TokenManager().refreshToken();
              if (newToken != null) {
                // 토큰을 성공적으로 갱신했을 때의 로직
                TokenManager().setToken(newToken); // 갱신된 토큰 저장

                // 원래의 요청을 다시 실행
                originalRequest.headers['Authorization'] = 'Bearer $newToken';
                originalRequest.headers['retry'] = (originalRequest.headers['retry'] ?? 0) + 1;
                final response = await _dio.fetch(originalRequest);
                return handler.resolve(response); // 새로운 응답으로 핸들러를 처리
              }
            } catch (error) {
              print("Failed to refresh token: $error");
              // 토큰 갱신 실패
            }
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
}
