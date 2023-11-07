import 'package:guncagacaonwer/order/models/orderrequestmodel.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'waitingpage_api_service.g.dart';

@RestApi(baseUrl : "https://k9d102.p.ssafy.io")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;
  
  @POST("/api/order/request/{orderId}")
  Future<OrderRequestResponse> requestOrder(@Header("Email") String email, @Path("orderId") String orderId);
}