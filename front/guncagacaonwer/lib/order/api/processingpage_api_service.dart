import 'package:guncagacaonwer/order/models/ordercompletemodel.dart';
import 'package:guncagacaonwer/order/models/orderlistmodel.dart';
import 'package:guncagacaonwer/store/models/ownerinfomodel.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'processingpage_api_service.g.dart';

@RestApi(baseUrl : "https://k9d102.p.ssafy.io")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // 주문 목록 리스트
  @GET("/api//list/{storeId}/{status}")
  Future<List<Order>> getProcessingList(
      @Path("storeId") int storeId,
      @Path("status") String status,
      );

  // 사장님 정보
  @GET("/api/ceo/ownerInfo")
  Future<OwnerInfoResponse> getOwnerInfo(@Header("Authorization") String token);

  // 주문 완료 요청
  @POST("/api/order/complete/{orderId}")
  Future<OrderCompleteResponse> completeOrder(@Header("Authorization") String token, @Path("orderId") String orderId);
}