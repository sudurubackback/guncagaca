import 'package:shared\_preferences/shared\_preferences.dart';
import 'package:guncagacaonwer/order/models/ordercancelmodel.dart';
import 'package:guncagacaonwer/order/models/orderlistmodel.dart';
import 'package:guncagacaonwer/order/models/orderrequestmodel.dart';
import 'package:guncagacaonwer/store/models/ownerinfomodel.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'waitingpage_api_service.g.dart';

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

  // 주문 접수
  @POST("/api/order/request/{orderId}")
  Future<OrderRequestResponse> requestOrder(@Path("orderId") String orderId);

  // 목록 리스트
  @GET("/api/order/list/{storeId}/{status}")
  Future<List<Order>> getWaitingList(
      @Path("storeId") int storeId,
      @Path("status") String status,
  );

  // 사장님 정보
  @GET("/api/owner/ownerInfo")
  Future<OwnerInfoResponse> getOwnerInfo();

  // 주문 취소
  @POST("/api/order/cancel")
  Future<String> cancelOrder(@Body() OrderCancelRequest request);
}