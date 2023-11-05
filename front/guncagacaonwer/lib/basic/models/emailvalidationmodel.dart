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
  final Map<String, dynamic> data;

  EmailValidationResponse(this.status, this.message, this.data);

  factory EmailValidationResponse.fromJson(Map<String, dynamic> json) {
    return EmailValidationResponse(
      json['status'] as int,
      json['message'] as String,
      json['data'] as Map<String, dynamic>,
    );
  }
}
