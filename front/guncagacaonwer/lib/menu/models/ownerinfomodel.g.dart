// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ownerinfomodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerInfoResponse _$OwnerInfoResponseFromJson(Map<String, dynamic> json) =>
    OwnerInfoResponse(
      json['email'] as String,
      json['tel'] as String,
      json['store_id'] as int,
    );

Map<String, dynamic> _$OwnerInfoResponseToJson(OwnerInfoResponse instance) =>
    <String, dynamic>{
      'email': instance.email,
      'tel': instance.tel,
      'store_id': instance.store_id,
    };
