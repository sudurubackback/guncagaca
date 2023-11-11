import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:guncagacaonwer/store/models/reviewmodel.dart';
import 'package:guncagacaonwer/store/models/ownerinfomodel.dart';

part 'review_api_service.g.dart';

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

  @GET("/api/store/{cafeId}/review")
  Future<List<ReviewResponse>> getReview(@Path("cafeId") int cafeId);

  @GET("/api/ceo/ownerInfo")
  Future<OwnerInfoResponse> getOwnerInfo();
}