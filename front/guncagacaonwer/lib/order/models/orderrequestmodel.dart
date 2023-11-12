import 'package:json_annotation/json_annotation.dart';

part 'orderrequestmodel.g.dart';

@JsonSerializable()
class OrderRequestResponse {
  final String message;

  OrderRequestResponse(this.message);

  factory OrderRequestResponse.fromJson(Map<String, dynamic> json) {
    return OrderRequestResponse(
      json['message'] as String
    );
  }
}