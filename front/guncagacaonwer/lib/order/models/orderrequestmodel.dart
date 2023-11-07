import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class OrderRequestResponse {
  final String message;

  OrderRequestResponse(this.message);

  factory OrderRequestResponse.fromJson(Map<String, String> json) {
    return OrderRequestResponse(
      json['message'] as String
    );
  }
}