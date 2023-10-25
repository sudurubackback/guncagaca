import 'package:flutter/material.dart';
import 'package:guncagaca/home/component/map_provider.dart';
import 'package:guncagaca/home/component/store_card.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart' as naver;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../component/store_card_list.dart';
import '../models/store.dart';


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

  List<Store> storeData = [
    Store(
      image: AssetImage('assets/image/cafe.PNG'),
      name: '커피비치 구미인동점',
      distance: 1.5,
      rating: 4.5,
      reviewCount: 10,
    ),
    Store(
      image: AssetImage('assets/image/cafe.PNG'), // 예시 이미지 경로
      name: '커피공감',
      distance: 3,
      rating: 4.0,
      reviewCount: 5,
    ),
    Store(
      image: AssetImage('assets/image/cafe.PNG'), // 예시 이미지 경로
      name: '가게3',
      distance: 3,
      rating: 4.0,
      reviewCount: 5,
    ),
    Store(
      image: AssetImage('assets/image/cafe.PNG'), // 예시 이미지 경로
      name: '가게4',
      distance: 3,
      rating: 4.0,
      reviewCount: 5,
    ),
    Store(
      image: AssetImage('assets/image/cafe.PNG'), // 예시 이미지 경로
      name: '가게5',
      distance: 3,
      rating: 4.0,
      reviewCount: 5,
    ),
  ];


  @override
  void initState() {
    _permission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mapProvider = context.watch<MapProvider>();

    return GestureDetector(
      onTap: () {
        // 화면 어디를 탭하더라도 포커스를 해제
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8.0,
                  ),
                ],
              ),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: '검색...',
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
                onSubmitted: (value) {
                  // 검색값 제출 시 수행될 로직 작성
                },
              ),
            ),
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
            Expanded(
              flex: 1,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: StoreCardList(stores: storeData),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
