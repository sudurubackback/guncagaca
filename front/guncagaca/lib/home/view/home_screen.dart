import 'package:flutter/material.dart';
import 'package:guncagaca/home/component/map_provider.dart';
import 'package:guncagaca/home/component/store_card.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart' as naver;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _permission() async {
    var requestStatus = await Permission.location.request();
    var status = await Permission.location.status;
    if (requestStatus.isPermanentlyDenied || status.isPermanentlyDenied) {
      null;
    }
  }

  @override
  void initState() {
    _permission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mapProvider = context.watch<MapProvider>();

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: naver.NaverMap(
              initLocationTrackingMode: mapProvider.trackingMode,
              initialCameraPosition: naver.CameraPosition(target: mapProvider.initLocation),
              locationButtonEnable: true,
              onMapCreated: (naver.NaverMapController controller) async {
                naver.LatLng currentLocation = (await controller.getCameraPosition()).target;
                // 여기서 currentLocation을 사용하려면 MapProvider에 해당 기능을 추가해야 합니다.
              },
            ),
          ),
          const Expanded(
            flex: 1,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: StoreCard(
                  image: AssetImage('assets/image/cafe.PNG'),
                  name: '커피비치 구미인동점',
                  distance: '1.5Km',
                  rating: 4.5,
                  reviewCount: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
