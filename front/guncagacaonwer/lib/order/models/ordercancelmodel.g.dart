// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ordercancelmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCancelRequest _$OrderCancelRequestFromJson(Map<String, dynamic> json) =>
    OrderCancelRequest(
      reason: json['reason'] as String,
      receiptId: json['receiptId'] as String,
      orderId: json['orderId'] as String,
    );

Map<String, dynamic> _$OrderCancelRequestToJson(OrderCancelRequest instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'receiptId': instance.receiptId,
      'orderId': instance.orderId,
    };
