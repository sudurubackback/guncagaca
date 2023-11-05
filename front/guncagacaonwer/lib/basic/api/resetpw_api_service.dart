import 'package:guncagacaonwer/basic/models/resetpwmodel.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'resetpw_api_service.g.dart';

@RestApi(baseUrl: "http://k9d102.p.ssafy.io:8000")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @PUT("/api/ceo/resetpw")
  Future<ResetPasswordResponse> resetPassword(@Body() ResetPasswordRequest request);
}