import 'package:dio/dio.dart';

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
          // 다른 공통적인 에러 처리 로직 추가 가능
          return handler.next(e);
        },
      ),
    );
    return _dio;
  }
}
