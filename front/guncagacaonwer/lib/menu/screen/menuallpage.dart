import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guncagacaonwer/common/const/colors.dart';
import 'package:guncagacaonwer/menu/api/menuallpage_api_service.dart';
import 'package:guncagacaonwer/menu/models/menuresponsemodel.dart';
import 'package:guncagacaonwer/menu/screen/menueditpage.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MenuAllPage extends StatefulWidget {
  @override
  _MenuAllPageState createState() => _MenuAllPageState();
}

class _MenuAllPageState extends State<MenuAllPage> {
  int selectedButtonIndex = 0;

  late ApiService apiService;
  static final storage = FlutterSecureStorage();

  Future<void> setupApiService() async {
    String? accessToken = await storage.read(key: 'accessToken');
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor(accessToken));
    dio.interceptors.add(LogInterceptor(responseBody: true));
    apiService = ApiService(dio);
  }
  Map<String, List<MenuEntity>> categorizedMenus = {};

  @override
  void initState() {
    super.initState();

    setupApiService().then((_) {
      _fetchMenus();
    });
  }

  void _fetchMenus() async {
    final ownerResponse = await apiService.getOwnerInfo();
    int storeId = ownerResponse.storeId;
    categorizedMenus = await apiService.getMenues(storeId.toString());
    setState(() {});
  }

  void changeMenuStatus(String menuId) async {
    await apiService.updateMenuStatus({'menuId': menuId});
  }

  void deleteMenu(String menuId) async {
    await apiService.deleteMenu({'menuId': menuId});
  }


  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardDeviceWidth = 510;
    final standardDeviceHeight = 330;

    return ListView.builder(
      itemCount: categorizedMenus.length,
      itemBuilder: (context, index) {
        String category = categorizedMenus.keys.elementAt(index); // 카테고리 이름
        List<MenuEntity> menus = categorizedMenus[category] ?? [];

        return Column(
          children: [
            // 카테고리 이름을 표시하는 Container
            Container(
              color: BACK_COLOR,
              width: deviceWidth,
              child: Column(
                children: [

                    Container(
                      height: 2,
                      color: PRIMARY_COLOR,
                    ),
                  Text(
                    category,
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            ),

            // 검은색 구분선
            Container(
              height: 2,
              color: PRIMARY_COLOR,
            ),

            // 메뉴를 표시하는 GridView.builder
            GridView.builder(
              shrinkWrap: true, // ListView 안의 GridView 사용을 위해 필요
              physics: NeverScrollableScrollPhysics(), // ListView 안의 GridView 스크롤 방지
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 4개씩 표시
                childAspectRatio: (deviceWidth / standardDeviceWidth) / (deviceHeight / standardDeviceHeight),
              ),
              itemCount: menus.length, // 메뉴 목록의 길이에 따라 박스 수 조정
              itemBuilder: (BuildContext context, int menuIndex) {
                MenuEntity menu = menus[menuIndex]; // 해당 인덱스의 메뉴 정보 가져오기
                return Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
                  decoration: BoxDecoration(
                    color: Colors.white, // 각 박스의 배경색
                    border: Border.all(
                      color: Colors.black, // 외각선 색상
                      width: 1.0, // 외각선 두께
                    ),
                  ),
                  width: 100 * (deviceWidth / standardDeviceWidth), // 각 박스의 너비
                  height: 150 * (deviceHeight / standardDeviceHeight), // 각 박스의 높이
                  child: Column(
                    children: [
                      // 이미지
                      GestureDetector(
                        onTap: () {
                          // changeMenuStatus(menuId);
                        },
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: menu.img, // 이미지 파일 경로
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                              width: 90 * (deviceWidth / standardDeviceWidth),
                              height: 70 * (deviceHeight / standardDeviceHeight),
                              // fit: BoxFit.cover,
                              color: menu.status == 'SOLD_OUT' ? Color.fromRGBO(0, 0, 0, 0.4) : null,
                            ),
                            if (menu.status == 'SOLD_OUT')
                              Center(
                                child: Text(
                                  'SOLD OUT',
                                  style: TextStyle(color: Colors.red, fontSize: 30),
                                ),
                              ),
                          ],
                        ),
                      ),
                      // 텍스트 중앙에 위치
                      SizedBox(
                        height: 3 * (deviceHeight / standardDeviceHeight),
                      ),
                      Text(
                        menu.name, // 박스에 할당된 텍스트 출력
                        textAlign: TextAlign.center, // 텍스트 중앙 정렬
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 2 * (deviceHeight / standardDeviceHeight),
                      ),
                      // 버튼들을 나란히 배치하는 Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 버튼들을 가로로 공간을 균등하게 분배하도록 설정
                        children: [
                          // 첫 번째 버튼
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return MenuEditPage(menuInfo: menu); // MenuEditPage는 메뉴 수정 페이지의 위젯입니다.
                                  },
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF038527),
                            ),
                            child: Text('수정'),
                          ),
                          // 두 번째 버튼
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('삭제 확인'),
                                    content: Text('정말 삭제하시겠습니까?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          // "삭제" 버튼을 누를 때 해당 항목을 리스트에서 제거하고 화면을 업데이트
                                          // deleteMenu(menu);
                                          // setState(() {
                                          //   // 리스트에서 항목 삭제하는 코드 (여기서는 예시로 index를 이용)
                                          //   int index = menulists.indexOf(menu); // menu는 삭제하려는 항목
                                          //   if (index != -1) {
                                          //     menulists.removeAt(index);
                                          //   }
                                          // });
                                          // Navigator.of(context).pop();
                                        },
                                        child: Text('삭제'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('취소'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFFF5E5E), // 버튼 1의 배경색을 빨간색으로 설정
                            ),
                            child: Text('삭제'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            // 검은색 구분선
            // Container(
            //   height: 2,
            //   color: PRIMARY_COLOR,
            // ),
          ],
        );
      },
    );
  }

}
