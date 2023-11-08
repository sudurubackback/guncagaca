import 'package:json_annotation/json_annotation.dart';

class OwnerInfoResponse {
  final String email;
  final String tel;
  final int store_id;

  OwnerInfoResponse(this.email, this.tel, this.store_id);

  factory OwnerInfoResponse.fromJson(Map<String, dynamic> json) {
    return OwnerInfoResponse(
      json['email'] as String,
      json['tel'] as String,
      json['store_id'] as int,
    );
  }
}