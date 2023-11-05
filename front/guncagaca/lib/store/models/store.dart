import 'package:flutter/material.dart';
import 'package:guncagaca/store/models/store_detail.dart';

class Store {
  final StoreDetail storeDetail;
  final double latitude;
  final double longitude;
  final double distance;      // 거리

  Store({
    required this.storeDetail,
    required this.distance,
    required this.latitude,
    required this.longitude,
  });

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      storeDetail: StoreDetail.fromMap(map['store']),
      latitude: map['latitude'],
      longitude: map['longitude'],
      distance: map['distance'],

    );
  }
}