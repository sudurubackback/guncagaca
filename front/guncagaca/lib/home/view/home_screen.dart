import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:guncagaca/home/component/map_provider.dart';
import 'package:guncagaca/home/component/store_card.dart';
import 'package:location/location.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart' as naver;
import 'package:naver_map_plugin/naver_map_plugin.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../common/utils/dio_client.dart';
import '../../common/utils/location_service.dart';
import '../../kakao/main_view_model.dart';
import '../component/store_card_list.dart';
import '../../store/models/store.dart';


class HomeScreen extends StatefulWidget {
  final MainViewModel mainViewModel;
  const HomeScreen({required this.mainViewModel,
    Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  naver.NaverMapController? _controller;
  LocationData? currentLocation;

  @override
  void initState() {
    super.initState();
    dotenv.load(fileName: '.env');  // .env 파일 로드
    _permission();
    _initCurrentLocationAndFetchCafes();
  }

  // 위치 권한 받기
  void _permission() async {
    var requestStatus = await Permission.location.request();
    var status = await Permission.location.status;
    if (requestStatus.isPermanentlyDenied || status.isPermanentlyDenied) {
      null;
    }
  }

  List<Store> storeData = []; // 카페 정보
  List<Marker> markers = []; // 마커 정보
  final LocationService locationService = LocationService();

  // 위치 정보를 초기화하고 카페 정보를 가져오는 함수
  Future<void> _initCurrentLocationAndFetchCafes() async {
    currentLocation = await locationService.getCurrentLocation();
    if (currentLocation != null) {
      fetchCafes();
    } else {
      print("위치 정보를 가져오지 못했습니다.");
    }
  }

  // 주변 카페 호출
  Future<void> fetchCafes() async {
    print("api호출");
    if (currentLocation == null) return;

    String baseUrl = dotenv.env['BASE_URL']!;
    Dio dio = DioClient.getInstance();

    print(currentLocation);
    final response = await dio.get("$baseUrl/api/store/list", queryParameters: {
      'lat': currentLocation!.longitude,
      'lon': currentLocation!.latitude
    });
    print('${currentLocation!.latitude} 위도');
    print('${currentLocation!.longitude} 경도');

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      print(data);
      setState(() {
        storeData = data.map((item) => Store.fromMap(item)).toList();
        createMarkersFromStores();
      });
    }
  }

  Future<void> refreshContent() async {
    await fetchCafes();
  }

  // 마커 찍기
  void createMarkersFromStores() {
    markers.clear();
    for (Store store in storeData) {
      Marker marker = Marker(
        markerId: store.storeId.toString(),
        position: LatLng(store.longitude, store.latitude),
        captionText: store.cafeName, // 마커에 표시할 텍스트
      );

      marker.onMarkerTab = (naver.Marker? marker, Map<String, int?>? iconSize) {
        if (marker?.position != null && iconSize != null) {
          _controller?.moveCamera(naver.CameraUpdate.scrollTo(marker!.position!));
        }
      };

      markers.add(marker);
    }
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
        body: RefreshIndicator(
          onRefresh: refreshContent,
          child: Column(
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
                  markers: List.from(markers),
                  initLocationTrackingMode: mapProvider.trackingMode,
                  initialCameraPosition: naver.CameraPosition(target: convertToLatLng(currentLocation)),
                  locationButtonEnable: true,
                  onMapCreated: (naver.NaverMapController controller) async {
                    _controller = controller;
                    naver.LatLng currentLocation = (await controller.getCameraPosition()).target;
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: StoreCardList(stores: storeData, mainViewModel: widget.mainViewModel,),
                  ),
                ),
              ),
            ],
          )
        ),
      )
    );
  }
}
