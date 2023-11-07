import 'package:guncagacaonwer/order/models/ordercancelmodel.dart';
import 'package:guncagacaonwer/order/models/orderlistmodel.dart';
import 'package:guncagacaonwer/order/models/orderrequestmodel.dart';
import 'package:guncagacaonwer/store/models/ownerinfomodel.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'waitingpage_api_service.g.dart';

@RestApi(baseUrl : "https://k9d102.p.ssafy.io")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // 주문 접수
  @POST("/api/order/request/{orderId}")
  Future<OrderRequestResponse> requestOrder(@Header("Email") String email, @Path("orderId") String orderId);

  // 목록 리스트
  @GET("/api/list/{storeId}/{status}")
  Future<List<Order>> getWaitingList(
      @Path("storeId") int storeId,
      @Path("status") String status,
  );

  // 사장님 정보
  @GET("/api/ceo/ownerInfo")
  Future<OwnerInfoResponse> getOwnerInfo(@Header("Authorization") String token);

  // 주문 취소
  @POST("/api/order/cancel")
  Future<String> cancelOrder(@Header("Email") String email, @Body() OrderCancelRequest request);
}