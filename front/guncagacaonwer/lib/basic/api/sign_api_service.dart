import 'package:guncagacaonwer/basic/models/businessvalidationmodel.dart';
import 'package:guncagacaonwer/basic/models/checkcodemodel.dart';
import 'package:guncagacaonwer/basic/models/emailvalidationmodel.dart';
import 'package:guncagacaonwer/basic/models/sendcodemodel.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:guncagacaonwer/basic/models/signmodel.dart';

part 'sign_api_service.g.dart';

@RestApi(baseUrl: "https://k9d102.p.ssafy.io")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;
  
  // 회원가입
  @POST("/api/ceo/signup")
  Future<SignUpResponse> signupUser(@Body() SignUpRequest request);

  // 이메일 유효성 체크
  @POST("/api/ceo/checkemail")
  Future<EmailValidationResponse> emailValidation(@Body() EmailValidationRequest request);

  // 이메일 인증 요청
  @POST("/api/ceo/sendcode")
  Future<SendCodeResponse> sendCode(@Body() SendCodeRequest request);
  
  @POST("/api/ceo/checkcode")
  Future<CheckCodeResponse> checkCode(@Body() CheckCodeRequest request);

  @POST("/api/ceo/cert")
  Future<BusinessValidationResponse> checkCert(@Body() BusinessValidationRequest request);
}