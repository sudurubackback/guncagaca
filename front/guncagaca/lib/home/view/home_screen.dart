
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart' as naver;
import 'package:naver_map_plugin/naver_map_plugin.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../common/const/colors.dart';
import '../../common/utils/dio_client.dart';
import '../../common/utils/location_service.dart';
import '../../common/utils/location_utils.dart';
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

  naver.NaverMapController? _controller;
  Position? currentLocation;
  OverlayImage? heartIcon;
  bool loading = true;
  final token = TokenManager().token;

  @override
  void initState() {
    super.initState();
    dotenv.load(fileName: '.env');  // .env 파일 로드
    _loadMarkerImages();
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
  String baseUrl = dotenv.env['BASE_URL']!;
  Dio dio = DioClient.getInstance();

  final LocationService locationService = LocationService();

  Future<void> _loadMarkerImages() async {
    heartIcon = await OverlayImage.fromAssetImage(
        assetName: 'assets/image/free-icon-heart.png',
      // devicePixelRatio: window.devicePixelRatio,
      // size: Size(5, 5),
    );
  }

  // 위치 정보를 초기화하고 카페 정보를 가져오는 함수
  Future<void> _initCurrentLocationAndFetchCafes() async {
    currentLocation = await locationService.getCurrentPosition();
    if (currentLocation != null) {
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
        markerId: store.storeDetail.storeId.toString(),
        position: LatLng(store.latitude, store.longitude),
        captionText: store.storeDetail.cafeName,
        icon: store.storeDetail.isLiked
            ? heartIcon : null,
        onMarkerTab: (naver.Marker? marker, Map<String, int?>? iconSize) {
          if (marker != null) {
            // 카메라를 해당 마커 위치로 이동
            _controller?.moveCamera(naver.CameraUpdate.scrollTo(marker.position!));
            // 가게 정보 다이얼로그 표시
            _showStoreInfoDialog(store);
          }
        },
      );
      markers.add(marker);
    }
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
                    : naver.NaverMap(
                  initLocationTrackingMode: naver.LocationTrackingMode.Follow,
                  initialCameraPosition: naver.CameraPosition(target: naverConvertToLatLng(currentLocation)),
                  locationButtonEnable: true,
                  markers: List.from(markers),
                  onMapCreated: (naver.NaverMapController controller) {
                    _controller = controller;
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
