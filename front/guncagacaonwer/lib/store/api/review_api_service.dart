import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:guncagacaonwer/store/models/reviewmodel.dart';
import 'package:guncagacaonwer/store/models/ownerinfomodel.dart';

part 'review_api_service.g.dart';

@RestApi(baseURl: "http://k9d102.p.ssafy.io:8000")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/cafe/{cafeId}/review")
  Future<List<ReviewResponse>> getReview(@Header("Authorization") String token, @Path("cafeId") Long cafeId);

  @Get("/api/ceo/ownerInfo")
  Future<OwnerInfoResponse> getOwnerInfo(@Header("Authorization") String token);
}