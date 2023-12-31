import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/const/colors.dart';
import '../../common/utils/dio_client.dart';
import '../../common/utils/location_service.dart';
import '../../common/utils/oauth_token_manager.dart';
import '../../kakao/main_view_model.dart';
import '../../store/view/store_detail_screen.dart';
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

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;

      setState(() {
        storeData = data.map((item) => Store.fromMap(item)).toList();
        createMarkersFromStores(storeData);
      });
    }
  }

  Future<void> refreshContent() async {
    await fetchCafes();
    filterMarkers();
  }

  void filterMarkers() {
    if (searchKeyword == null || searchKeyword!.isEmpty) {
      // 검색어가 없는 경우 모든 상점을 표시합니다.
      createMarkersFromStores(storeData);
    } else {
      // 검색어가 있는 경우 해당하는 상점만 필터링합니다.
      List<Store> filteredStores = storeData.where((store) {
        return store.storeDetail.cafeName.toLowerCase().contains(searchKeyword!);
      }).toList();
      createMarkersFromStores(filteredStores);
    }
  }

  void createMarkersFromStores(List<Store> stores) {
    if (stores.isEmpty) {
      return;
    }
    markers.clear();

    for (Store store in stores) {
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
          cameraUpdate.setAnimation(animation: NCameraAnimation.easing, duration: Duration(milliseconds: 100));
          _controller?.updateCamera(cameraUpdate).then((_) {
            _showStoreInfoDialog(store);
          });
        });
        markers.add(marker);
      } else { // 찜 가게 아닌 경우
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
      // 기존마커 제거
      _controller!.clearOverlays();
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
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.to(() => StoreDetailScreen(
                  mainViewModel: widget.mainViewModel,
                  storeId: store.storeDetail.storeId,
                ));
              },
              style: ElevatedButton.styleFrom(
                primary: PRIMARY_COLOR,
              ),
              child: Text('가게로 이동', style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: PRIMARY_COLOR,
              ),
              child: Text('닫기', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        // 사용자에게 URL을 열 수 없음을 알림
        throw 'Could not launch $url';
      }
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: refreshContent,
          child: SingleChildScrollView(
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
                        filterMarkers();
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: '검색...',
                      border: InputBorder.none,
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
                Container(
                  height: screenHeight / 3,
                  child: loading
                  ? Center(child: CircularProgressIndicator())
                  : NaverMap(
                    forceGesture: true,
                      options: NaverMapViewOptions(
                        locationButtonEnable: true,
                        initialCameraPosition: NCameraPosition(target: nLatLng, zoom: 15),
                      ),
                      onMapReady: (controller) async {
                        _controller = controller;
                        await _controller?.setLocationTrackingMode(NLocationTrackingMode.follow);

                        if(markers.isNotEmpty){
                          await _controller?.addOverlayAll(markers);
                        }
                      },
                    ),
                  ),
                SizedBox(height: 20),
                Container(
                  height: screenHeight / 2,
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
                Container(
                  width: double.infinity,
                  // constraints: BoxConstraints( // 최대 높이 제한
                  //   maxHeight: MediaQuery.of(context).size.height * 0.1, // 예를 들어 화면 높이의 30%로 제한
                  // ),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => _launchURL('https://sites.google.com/view/guncagaca/%ED%99%88'),
                        child: Text(
                          '개인정보처리방침',
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                            fontSize: 10
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('상호명 : 근카가카 | 대표자명 : 최성우 ',
                          style: TextStyle(fontSize: 7)),
                      SizedBox(height: 8),
                      Text('담당자: 최영태 | 이메일 : dudxo7721@naver.com',
                          style: TextStyle(fontSize: 7)),
                      SizedBox(height: 8),
                      Text('소재지 : 대구시 달서구 죽전1길 82',
                          style: TextStyle(fontSize: 7)),
                      Text('사업자번호: 668-09-02525',
                          style: TextStyle(fontSize: 7)),
                      Text('통신판매업신고번호: 2023-대구달서-00000',
                          style: TextStyle(fontSize: 7)),
                      Text('고객센터번호: 070-8018-6553',
                          style: TextStyle(fontSize: 7)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
