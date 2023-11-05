import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class EmailValidationRequest {
  String email;

  EmailValidationRequest(this.email);

  Map<String, String> toJson() {
    return {
      'email' : email
    };
  }
}

@JsonSerializable()
class EmailValidationResponse {
  final int status;
  final String message;

  EmailValidationResponse(this.status, this.message);

  factory EmailValidationResponse.fromJson(Map<String, dynamic> json) {
    return EmailValidationResponse(
      json['status'] as int,
      json['message'] as String,
    );
  }
}
