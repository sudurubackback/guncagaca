import 'package:json_annotation/json_annotation.dart';

part 'ordercompletemodel.g.dart';

@JsonSerializable()
class OrderCompleteResponse {
  final String message;

  OrderCompleteResponse(this.message);

  factory OrderCompleteResponse.fromJson(Map<String, dynamic> json) {
    return OrderCompleteResponse(
        json['message'] as String
    );
  }
}