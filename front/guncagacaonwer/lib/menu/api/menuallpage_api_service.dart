import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'menuallpage_api_service.g.dart';

class AuthInterceptor extends Interceptor {
  final String? token;

  AuthInterceptor(this.token);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }
    super.onRequest(options, handler);
  }
}

@RestApi(baseUrl: "https://k9d102.p.ssafy.io")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @PUT("/api/ceo/menu/sale")
  Future<void> updateMenuStatus(@Body() Map<String, dynamic> menuId);

  @DELETE("/api/ceo/menu/delete")
  Future<void> deleteMenu(@Body() Map<String, dynamic> menuId);
}