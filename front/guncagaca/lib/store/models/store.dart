import 'package:flutter/material.dart';

class Store {
  final int storeId;
  final String img;  // 가게 이미지
  final String cafeName;          // 가게 이름
  final double latitude;
  final double longitude;
  final double distance;      // 거리
  final double starTotal;        // 평점
  final int reviewCount;      // 리뷰 수

  Store({
    required this.storeId,
    required this.img,
    required this.cafeName,
    required this.distance,
    required this.latitude,
    required this.longitude,
    required this.starTotal,
    required this.reviewCount,
  });

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      storeId: map['storeId'],
      img: map['img'],
      cafeName: map['cafeName'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      distance: map['distance'],
      starTotal: map['starTotal'],
      reviewCount: map['reviewCount'],
    );
  }
}