
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
  const HomeScreen({required this.mainViewModel,
    Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {

  TextEditingController searchController = TextEditingController();
  String? searchKeyword; // 검색어를 저장하기 위한 변수 추가

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
  Set<NAddableOverlay> markers = {}; // 마커 정보
  String baseUrl = dotenv.env['BASE_URL']!;
  Dio dio = DioClient.getInstance();

  final LocationService locationService = LocationService();

  // 위치 정보를 초기화하고 카페 정보를 가져오는 함수
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

  // 주변 카페 호출
  Future<void> fetchCafes() async {
    if (currentLocation == null) return;
    print(currentLocation);

    final String apiUrl = "$baseUrl/api/store/list";
    final response = await dio.get(
        apiUrl,
        options: Options(
            headers: {
              'Authorization': "Bearer $token",
            }
        ),
        queryParameters: {
          'lat': currentLocation!.latitude,
          'lon': currentLocation!.longitude
        }
    );

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
      // final overlay = NOverlayMakerUtil.makeOverlay(
      //     type: NOverlayType.marker,
      //     cameraPosition: NCameraPosition(target: NLatLng(store.latitude, store.longitude), zoom: 15),
      //     id: store.storeDetail.storeId.toString());
      final marker = NMarker(
        id: store.storeDetail.storeId.toString(),
        position: NLatLng(store.latitude, store.longitude),
        // subCaption: NOverlayCaption(text: store.storeDetail.cafeName),
        // icon: NOverlayImage('assets/image/free-icon-heart.png', file),
      );
      markers.add(marker);
    }
    print(markers);
  }


  // 가게 정보 다이얼로그
  void _showStoreInfoDialog(Store store) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              Expanded(child: Text(store.storeDetail.cafeName, style: TextStyle(fontWeight: FontWeight.bold))),
              Icon(store.storeDetail.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: store.storeDetail.isLiked ? Colors.red : Colors.grey)
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
                    Text('평점: ${store.storeDetail.starTotal.toString()}'),
                    SizedBox(width: 20),
                    Text('리뷰 수: ${store.storeDetail.reviewCount}')
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16.0),
                    SizedBox(width: 5),
                    Flexible(child: Text('${store.storeDetail.openTime}')),
                    Text(' - '),
                    Flexible(child: Text('${store.storeDetail.closeTime}'))
                  ],
                ),
                SizedBox(height: 5),
                Text(store.storeDetail.isOpen
                    ? '영업 중'
                    : '영업 종료',
                    style: TextStyle(color: store.storeDetail.isOpen ? Colors.green : Colors.red)),
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
                  controller: searchController, // 검색어를 입력 받을 컨트롤러
                  onChanged: (value) {
                    setState(() {
                      // StoreCardList에 검색어를 전달하여 필터링
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
                    ? Center(child: CircularProgressIndicator())  // 로딩 중일 때 로딩 인디케이터 표시
                    : NaverMap(
                  options: NaverMapViewOptions(
                    locationButtonEnable: true,
                    initialCameraPosition: NCameraPosition(target: nLatLng, zoom: 15),
                  ),
                  onMapReady: (controller) async {
                    _controller = controller;
                    await _controller?.setLocationTrackingMode(NLocationTrackingMode.follow);
                    await _controller?.addOverlayAll(markers);

                  }
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
                      searchKeyword: searchKeyword, // 검색어를 전달
                    ),
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
