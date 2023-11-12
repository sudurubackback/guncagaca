import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'reviewmodel.g.dart';

@JsonSerializable()
class ReviewResponse {
  final int reviewId;
  final String nickname;
  final double star;
  final String content;

  ReviewResponse(this.reviewId, this.nickname, this.star, this.content);

  factory ReviewResponse.fromJson(Map<String, dynamic> json) {
    return ReviewResponse(
      json['reviewId'] as int,
      json['nickname'] as String,
      json['star'] as double,
      json['content'] as String,
    );
  }
}