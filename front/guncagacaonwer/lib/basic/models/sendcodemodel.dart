import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SendCodeRequest {
  String email;

  SendCodeRequest(this.email);

  Map<String, String> toJson() {
    return {
      'email' : email,
    };
  }
}

@JsonSerializable()
class SendCodeResponse {
  final int status;
  final String message;

  SendCodeResponse(this.status, this.message);

  factory SendCodeResponse.fromJson(Map<String, dynamic> json) {
    return SendCodeResponse(
      json['status'] as int,
      json['message'] as String,
    );
  }
}