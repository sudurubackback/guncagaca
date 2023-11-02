import 'package:flutter/foundation.dart';
import 'package:guncagaca/common/utils/location_service.dart';
import 'package:location/location.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart' show LatLng, LocationTrackingMode;

import '../../common/utils/location_class.dart';

class MapProvider with ChangeNotifier {
  final LocationService _locationService = LocationService();

  // LocationClass로 캐시된 초기 위치를 사용
  LatLng get initLocation => convertToLatLng(_locationService.initLocation);

  MapProvider() {
    setCurrentLocation();
  }

  LocationTrackingMode _trackingMode = LocationTrackingMode.None;

  LocationTrackingMode get trackingMode => this._trackingMode;

  set trackingMode(LocationTrackingMode m) => throw "error";

  Future<void> setCurrentLocation() async {
    if (await this._locationService.canGetCurrentLocation()) {
      this._trackingMode = LocationTrackingMode.Follow;
      this.notifyListeners();
    }
  }
}

LatLng convertToLatLng(LocationData? data) {
  if (data == null) {
    return LatLng(0, 0); // 기본값을 제공하거나 오류를 처리합니다.
  }
  return LatLng(data.latitude!, data.longitude!);
}
