import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CheckCodeRequest {
  String email;
  String code;

  CheckCodeRequest(this.email, this.code);

  Map<String, String> toJson() {
    return {
      'email' : email,
      'code' : code,
    };
  }
}

@JsonSerializable()
class CheckCodeResponse {
  final int status;
  final String message;

  CheckCodeResponse(this.status, this.message);

  factory CheckCodeResponse.fromJson(Map<String, dynamic> json) {
    return CheckCodeResponse(
      json['status'] as int,
      json['message'] as String,
    );
  }
}