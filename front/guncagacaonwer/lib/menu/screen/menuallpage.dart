import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared\_preferences/shared\_preferences.dart';
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

  Future<void> setupApiService() async {
    final prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    print("여기 있음 ${accessToken}");
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
    categorizedMenus = await apiService.getMenues(storeId);
    setState(() {});
  }

  void changeMenuStatus(String menuId) async {
    await apiService.updateMenuStatus(menuId);

    setState(() {
      _fetchMenus();
    });
  }

  void deleteMenu(String menuId) async {
    await apiService.deleteMenu(menuId);
  }

  void _openEditMenuPage(MenuEntity menu) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MenuEditPage(menuInfo: menu)),
    );

    // 수정 창이 닫히고 수정이 성공적으로 이루어진 경우
    if (result != null && result == true) {
      _fetchMenus();  // 데이터 갱신
    }
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
                          changeMenuStatus(menu.id);
                        },
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: menu.img, // 이미지 파일 경로
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                              width: 80 * (deviceWidth / standardDeviceWidth),
                              height: 70 * (deviceHeight / standardDeviceHeight),
                              fit: BoxFit.cover,
                            ),
                            if (menu.status == 'SOLD_OUT')
                              Container(
                                width: 90 * (deviceWidth / standardDeviceWidth),
                                height: 70 * (deviceHeight / standardDeviceHeight),
                                color: Color.fromRGBO(0, 0, 0, 0.4),
                                child: Center(
                                  child: Text(
                                    '품절',
                                    style: TextStyle(color: Colors.red, fontSize: 30),
                                  ),
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
                              _openEditMenuPage(menu);  // 수정 버튼을 누르면 _openEditMenuPage 함수가 실행됩니다.
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
                                          deleteMenu(menu.id);
                                          _fetchMenus();
                                          Navigator.of(context).pop();
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
