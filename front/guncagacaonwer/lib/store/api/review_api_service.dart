import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:guncagacaonwer/store/models/reviewmodel.dart';
import 'package:guncagacaonwer/store/models/ownerinfomodel.dart';

part 'review_api_service.g.dart';

@RestApi(baseUrl: "http://k9d102.p.ssafy.io:8000")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/api/store/{cafeId}/review")
  Future<List<ReviewResponse>> getReview(@Header("Authorization") String token, @Path("cafeId") int cafeId);

  @GET("/api/ceo/ownerInfo")
  Future<OwnerInfoResponse> getOwnerInfo(@Header("Authorization") String token);
}