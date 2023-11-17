import 'package:json_annotation/json_annotation.dart';

class OwnerInfoResponse {
  final String email;
  final String tel;
  final int storeId;

  OwnerInfoResponse(this.email, this.tel, this.storeId);

  factory OwnerInfoResponse.fromJson(Map<String, dynamic> json) {
    return OwnerInfoResponse(
      json['email'] as String,
      json['tel'] as String,
      json['storeId'] as int,
    );
  }
}