// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviewmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewResponse _$ReviewResponseFromJson(Map<String, dynamic> json) =>
    ReviewResponse(
      json['reviewId'] as int,
      json['nickname'] as String,
      (json['star'] as num).toDouble(),
      json['content'] as String,
    );

Map<String, dynamic> _$ReviewResponseToJson(ReviewResponse instance) =>
    <String, dynamic>{
      'reviewId': instance.reviewId,
      'nickname': instance.nickname,
      'star': instance.star,
      'content': instance.content,
    };
