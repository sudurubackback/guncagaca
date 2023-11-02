import 'package:flutter/material.dart';

class StoreDetail {
  final int storeId;
  final String img;  // 가게 이미지
  final String cafeName;          // 가게 이름
  final double starTotal;        // 평점
  final int reviewCount;      // 리뷰 수
  final String description;
  final bool isLiked;

  StoreDetail({
    required this.storeId,
    required this.img,
    required this.cafeName,
    required this.starTotal,
    required this.reviewCount,
    required this.isLiked,
    required this.description
  });

  factory StoreDetail.fromMap(Map<String, dynamic> map) {
    return StoreDetail(
      storeId: map['storeId'],
      img: map['img'],
      cafeName: map['cafeName'],
      starTotal: map['starPoint'],
      reviewCount: map['reviewCount'],
      isLiked: map['liked'],
      description: map['description']
    );
  }
}