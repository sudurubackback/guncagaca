import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ResetPasswordRequest {
  String email;

  ResetPasswordRequest(this.email);

  Map<String, String> toJson() {
    return {
      'email': email
    };
  }
}

@JsonSerializable()
class ResetPasswordResponse {
  final int status;
  final String message;

  ResetPasswordResponse(this.status, this.message);

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
        json['status'] as int,
        json['message'] as String
    );
  }
}