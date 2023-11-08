import 'package:guncagacaonwer/order/models/ordercompletemodel.dart';
import 'package:guncagacaonwer/order/models/orderlistmodel.dart';
import 'package:guncagacaonwer/store/models/ownerinfomodel.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'processingpage_api_service.g.dart';

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

  // 주문 목록 리스트
  @GET("/api/list/{storeId}/{status}")
  Future<List<Order>> getProcessingList(
      @Path("storeId") int storeId,
      @Path("status") String status,
      );

  // 사장님 정보
  @GET("/api/ceo/ownerInfo")
  Future<OwnerInfoResponse> getOwnerInfo();

  // 주문 완료 요청
  @POST("/api/order/complete/{orderId}")
  Future<OrderCompleteResponse> completeOrder(@Path("orderId") String orderId);
}