import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ChangePasswordRequest {
  String newpassword;
  String password;

  ChangePasswordRequest(this.newpassword, this.password);

  Map<String, String> toJson() {
    return {
      'newpassword' : newpassword,
      'password' : password,
    };
  }
}

@JsonSerializable()
class ChangePasswordResponse {
  final int status;
  final String message;

  ChangePasswordResponse(this.status, this.message);

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(
        json['status'] as int,
        json['message'] as String
    );
  }
}