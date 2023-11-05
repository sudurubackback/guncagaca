import 'package:geolocator/geolocator.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart' as naver;

naver.LatLng naverConvertToLatLng(Position? data) {
  return naver.LatLng(data!.latitude!, data!.longitude!);
}
