import 'package:flutter/material.dart';

class StoreDetail {
  final int storeId;
  final String cafeName;
  final double starTotal;
  final int reviewCount;
  final String img;
  final String address;
  final String description;
  final String openTime;
  final String closeTime;
  final bool isOpen;
  final bool isLiked;

  StoreDetail({
    required this.storeId,
    required this.cafeName,
    required this.starTotal,
    required this.reviewCount,
    required this.img,
    required this.address,
    required this.description,
    required this.openTime,
    required this.closeTime,
    required this.isOpen,
    required this.isLiked,
  });

  factory StoreDetail.fromMap(Map<String, dynamic> map) {
    return StoreDetail(
      storeId: map['storeId'],
      cafeName: map['cafeName'],
      starTotal: map['starPoint'],
      reviewCount: map['reviewCount'],
      img: map['img'],
      address: map['address'],
      description: map['description'],
      openTime: map['openTime'],
      closeTime: map['closeTime'],
      isOpen: map['open'],
      isLiked: map['liked'],
    );
  }
}