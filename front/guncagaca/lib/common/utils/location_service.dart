import 'package:location/location.dart';

class LocationService {
  Location location = new Location();
  LocationData? initLocation;

  Future<LocationData?> getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData? locationData;


    // 서비스 활성화 확인
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    // 권한 확인
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    // 현재 위치 획득 후 캐싱
    locationData = await location.getLocation();
    initLocation = locationData; // 현재 위치 캐싱
    return locationData;
  }

  Future<bool> canGetCurrentLocation() async {
    return (await getCurrentLocation()) != null;
  }
}
