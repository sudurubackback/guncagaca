import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:guncagaca/home/component/overlay_util.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../common/const/colors.dart';
import '../../common/utils/dio_client.dart';
import '../../common/utils/location_service.dart';
import '../../common/utils/oauth_token_manager.dart';
import '../../kakao/main_view_model.dart';
import '../component/store_card_list.dart';
import '../../store/models/store.dart';

class HomeScreen extends StatefulWidget {
  final MainViewModel mainViewModel;
  const HomeScreen({
    required this.mainViewModel,
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  TextEditingController searchController = TextEditingController();
  String? searchKeyword;

  @override
  bool get wantKeepAlive => true;

  NOverlayType willCreateOverlayType = NOverlayType.marker;
  NAddableOverlay? willCreateOverlay;
  NaverMapController? _controller;
  Position? currentLocation;
  late NLatLng nLatLng;
  bool loading = true;
  final token = TokenManager().token;

  @override
  void initState() {
    super.initState();
    dotenv.load(fileName: '.env');
    _permission();
    _initCurrentLocationAndFetchCafes();
  }

  void _permission() async {
    var requestStatus = await Permission.location.request();
    var status = await Permission.location.status;
    if (requestStatus.isPermanentlyDenied || status.isPermanentlyDenied) {
      return; // return 추가
    }
  }

  List<Store> storeData = [];
  Set<NAddableOverlay> markers = {};
  String baseUrl = dotenv.env['BASE_URL']!;
  Dio dio = DioClient.getInstance();

  final LocationService locationService = LocationService();

  Future<void> _initCurrentLocationAndFetchCafes() async {
    currentLocation = await locationService.getCurrentPosition();

    if (currentLocation != null) {
      nLatLng = NLatLng(currentLocation!.latitude, currentLocation!.longitude);
      fetchCafes();
    } else {
      print("위치 정보를 가져오지 못했습니다.");
    }
    setState(() {
      loading = false;
    });
  }

  Future<void> fetchCafes() async {
    if (currentLocation == null) return;

    final String apiUrl = "$baseUrl/api/store/list";
    try {
      final response = await dio.get(
        apiUrl,
        options: Options(
          headers: {
            'Authorization': "Bearer $token",
          },
        ),
        queryParameters: {
          'lat': currentLocation!.latitude,
          'lon': currentLocation!.longitude,
        },
      );

      print("API 응답: $response");

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        print("마커 200");
        print(data);
        setState(() {
          storeData = data.map((item) => Store.fromMap(item)).toList();
          createMarkersFromStores();
        });
      }
    } catch (e) {
      print("API 호출 중 오류 발생: $e");
    }
  }

  Future<void> refreshContent() async {
    await fetchCafes();
  }

  void createMarkersFromStores() {
    if (storeData.isEmpty) {
      return;
    }
    markers.clear();

    for (Store store in storeData) {
      final marker;
      // 찜 가게인 경우
      if (store.storeDetail.isLiked) {
        marker = NMarker(
          id: store.storeDetail.storeId.toString(),
          position: NLatLng(store.latitude, store.longitude),
          caption: NOverlayCaption(text: store.storeDetail.cafeName),
          icon: NOverlayImage.fromAssetImage("assets/image/free-icon-heart.png"),
          size: Size.fromRadius(17.0)
        );
        // 마커 터치시 이동하고 다이얼로그 창 실행
        marker.setOnTapListener((overlay) {
          final cameraUpdate = NCameraUpdate.scrollAndZoomTo(target: marker.position, zoom: 15);
          cameraUpdate.setAnimation(animation: NCameraAnimation.easing, duration: Duration(seconds: 1));
          _controller?.updateCamera(cameraUpdate).then((_) {
            _showStoreInfoDialog(store);
          });
        });
        markers.add(marker);
      } else {
        marker = NMarker(
          id: store.storeDetail.storeId.toString(),
          position: NLatLng(store.latitude, store.longitude),
          caption: NOverlayCaption(text: store.storeDetail.cafeName),
            size: Size.fromRadius(20.0)
        );
        marker.setOnTapListener((overlay) {
          final cameraUpdate = NCameraUpdate.scrollAndZoomTo(target: marker.position, zoom: 15);
          cameraUpdate.setAnimation(animation: NCameraAnimation.easing, duration: Duration(seconds: 1));
          _controller?.updateCamera(cameraUpdate).then((_) {
            _showStoreInfoDialog(store);
          });
        });
        markers.add(marker);
      }
    }

    if (_controller != null) {
      _controller!.addOverlayAll(markers);
      print("createMarkersFromStores: Markers created and added successfully");
    } else {
      print("_controller is null, unable to add markers");
    }
  }

        // 마커 터치시 이동하고 다이얼로그 창 실행
  void _showStoreInfoDialog(Store store) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              Expanded(child: Text(store.storeDetail.cafeName, style: TextStyle(fontWeight: FontWeight.bold))),
              Icon(
                store.storeDetail.isLiked ? Icons.favorite : Icons.favorite_border,
                color: store.storeDetail.isLiked ? Colors.red : Colors.grey,
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                store.storeDetail.img.isNotEmpty
                    ? Image.network(store.storeDetail.img, width: 200.0, height: 150.0, fit: BoxFit.cover)
                    : Container(),
                SizedBox(height: 10),
                Text('주소: ${store.storeDetail.address}'),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text('평점: ${store.storeDetail.starTotal.toStringAsFixed(2)}'),
                    SizedBox(width: 20),
                    Text('리뷰 수: ${store.storeDetail.reviewCount}'),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16.0),
                    SizedBox(width: 5),
                    Flexible(child: Text('${store.storeDetail.openTime}')),
                    Text(' - '),
                    Flexible(child: Text('${store.storeDetail.closeTime}')),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  store.storeDetail.isOpen ? '영업 중' : '영업 종료',
                  style: TextStyle(color: store.storeDetail.isOpen ? Colors.green : Colors.red),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('닫기', style: TextStyle(color: PRIMARY_COLOR)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchKeyword = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: '검색...',
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: loading
                    ? Center(child: CircularProgressIndicator())
                    : NaverMap(
                  options: NaverMapViewOptions(
                    locationButtonEnable: true,
                    initialCameraPosition: NCameraPosition(target: nLatLng, zoom: 15),
                  ),
                  onMapReady: (controller) async {
                    if (controller == null) {
                      print("_controller is null");
                      return;
                    }

                    _controller = controller;
                    await _controller?.setLocationTrackingMode(NLocationTrackingMode.follow);
                    print("onMapReady: Controller initialized successfully");

                    if(markers.isNotEmpty){
                      await _controller?.addOverlayAll(markers);
                      print("onMapReady: Markers added successfully");
                    } else {
                      print("onMapReady: No markers to add");
                    }
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: StoreCardList(
                      stores: storeData,
                      mainViewModel: widget.mainViewModel,
                      searchKeyword: searchKeyword,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
