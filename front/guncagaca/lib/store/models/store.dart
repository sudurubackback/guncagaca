import 'package:flutter/material.dart';

class Store {
  final ImageProvider image;  // 가게 이미지
  final String name;          // 가게 이름
  final double distance;      // 거리
  final double rating;        // 평점
  final int reviewCount;      // 리뷰 수
  final String description;

  Store({
    required this.image,
    required this.name,
    required this.distance,
    required this.rating,
    required this.reviewCount,
    required this.description,
  });
}