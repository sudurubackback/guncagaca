import 'package:json_annotation/json_annotation.dart';

part 'ordercancelmodel.g.dart';

@JsonSerializable()
class OrderCancelRequest {
  final String reason;
  final String receiptId;
  final String orderId;

  OrderCancelRequest({
    required this.reason,
    required this.receiptId,
    required this.orderId,
  });

  Map<String, dynamic> toJson() {
    return {
      'reason': reason,
      'receiptId': receiptId,
      'orderId': orderId,
    };
  }
}
