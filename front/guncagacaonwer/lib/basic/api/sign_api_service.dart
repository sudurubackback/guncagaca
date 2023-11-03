import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:guncagacaonwer/basic/models/signmodel.dart';

part 'sign_api_service.g.dart';

@RestApi(baseUrl: "http://k9d102.p.ssafy.io:8000")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;
  
  @POST("/api/ceo/signup")
  Future<SignUpResponse> signupUser(@Body() SignUpRequest request);
}