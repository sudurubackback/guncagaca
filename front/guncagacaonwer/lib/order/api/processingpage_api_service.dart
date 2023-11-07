import 'package:guncagacaonwer/order/models/orderlistmodel.dart';
import 'package:guncagacaonwer/store/models/ownerinfomodel.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'processingpage_api_service.g.dart';

@RestApi(baseUrl : "https://k9d102.p.ssafy.io")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/api//list/{storeId}/{status}")
  Future<List<Order>> getProcessingList(
      @Path("storeId") int storeId,
      @Path("status") String status,
      );

  @GET("/api/ceo/ownerInfo")
  Future<OwnerInfoResponse> getOwnerInfo(@Header("Authorization") String token);
}