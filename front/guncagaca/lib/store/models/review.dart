import 'package:flutter/material.dart';

class Review {
  final int reviewId;
  final String nickname;
  final String content;
  final double star;

  Review({
    required this.reviewId,
    required this.nickname,
    required this.content,
    required this.star
  });

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      reviewId: map['reviewId'],
      nickname: map['nickname'],
      content: map['content'],
      star: map['star'],
    );
  }

}