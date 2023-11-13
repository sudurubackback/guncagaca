import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:guncagacaonwer/menu/models/menuresponsemodel.dart';
import 'package:guncagacaonwer/menu/models/ownerinfomodel.dart';

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

  @PUT("/api/owner/menu/sale")
  Future<void> updateMenuStatus(@Body() String menuId);

  @DELETE("/api/owner/menu/delete")
  Future<void> deleteMenu(@Body() String menuId);
  
  @GET("/api/owner/{storeId}/menu")
  Future<Map<String, List<MenuEntity>>> getMenues(@Path() int storeId);

  @GET("/api/owner/ownerInfo")
  Future<OwnerInfoResponse> getOwnerInfo();
}