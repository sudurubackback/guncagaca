import 'package:guncagacaonwer/order/models/orderlistmodel.dart';
import 'package:guncagacaonwer/store/models/ownerinfomodel.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'completepage_api_service.g.dart';

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

@RestApi(baseUrl : "https://k9d102.p.ssafy.io")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/store/{storeId}/orders")
  Future<List<StoreOrderResponse>> getStoreOrdersForDateRange(@Path() int storeId, @Query('startDate') String startDate, @Query('endDate') String endDate);

  @GET("/api/ceo/ownerInfo")
  Future<OwnerInfoResponse> getOwnerInfo();
}