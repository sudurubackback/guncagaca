// 회원가입 요청 데이터 모델
import 'dart:ffi';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SignUpRequest {
  final String email;
  final String password;
  final String tel;
  final int business_id;

  SignUpRequest(this.email, this.password, this.tel, this.business_id);

  Map<String, dynamic> toJson() {
    return {
      'email' : email,
      'password' : password,
      'tel' : tel,
      'business_id' : business_id,
    };
  }
}

// 회원가입 응답 데이터 모델
@JsonSerializable()
class SignUpResponse {
  final int status;
  final String message;

  SignUpResponse(this.status, this.message);

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      json['status'] as int,
      json['message'] as String,
    );
  }
}
