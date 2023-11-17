// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ownerinfomodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerInfoResponse _$OwnerInfoResponseFromJson(Map<String, dynamic> json) =>
    OwnerInfoResponse(
      json['email'] as String,
      json['tel'] as String,
      json['storeId'] as int,
    );

Map<String, dynamic> _$OwnerInfoResponseToJson(OwnerInfoResponse instance) =>
    <String, dynamic>{
      'email': instance.email,
      'tel': instance.tel,
      'storeId': instance.storeId,
    };
