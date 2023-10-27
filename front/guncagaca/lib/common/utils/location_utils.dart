import 'package:location/location.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart' as naver;

naver.LatLng convertToLatLng(LocationData data) {
  return naver.LatLng(data.latitude!, data.longitude!);
}
