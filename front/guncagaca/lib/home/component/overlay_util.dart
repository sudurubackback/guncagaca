import 'package:flutter_naver_map/flutter_naver_map.dart';

class NOverlayMakerUtil {

  static NAddableOverlay makeOverlay({
    required NOverlayType type,
    required NCameraPosition cameraPosition,
    required String id,
  }) {
    final overlayId = id;

    final point = cameraPosition.target;
    // final heartCoords = NOverlayMakerUtil.getHeartCoordinates(
    //     cameraPosition.target,
    //     zoomLevel: cameraPosition.zoom);
    // final pathCoords = [
    //   point,
    //   point.offsetByMeter(northMeter: -100, eastMeter: 100),
    //   point.offsetByMeter(northMeter: -200),
    //   point.offsetByMeter(northMeter: -300, eastMeter: 100),
    // ];
    // final secondPathCoords = [
    //   pathCoords.last,
    //   pathCoords.last.offsetByMeter(northMeter: -100, eastMeter: -100),
    //   pathCoords.last.offsetByMeter(northMeter: -200),
    // ];
    return NMarker(id: overlayId, position: point);
  }
}