import 'package:flutter/material.dart';
import 'package:guncagacaonwer/common/layout/default_layout.dart';
import 'package:guncagacaonwer/menu/screen/menupage.dart';
import 'package:guncagacaonwer/order/screen/orderpage.dart';
import 'package:guncagacaonwer/store/screen/mypage.dart';
import 'package:guncagacaonwer/store/screen/reviewpage.dart';
import 'package:guncagacaonwer/store/screen/infopage.dart';

import '../../common/const/colors.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  int selectedButtonIndex = 0;

  Widget buildRightContent() {
    switch (selectedButtonIndex) {
      case 0:
        return MyPageScreen();
    // return Center(child: Text("나머지 영역의 내용"));
      case 1:
        return ReviewPage();
    // return Center(child: Text("나머지 영역의 내용"));
      case 2:
        return StoreInfoPage();
    // return Center(child: Text("나머지 영역의 내용"));
      default:
        return Center(child: Text("나머지 영역의 내용"));
    }
  }

  void navigateToPage(int pageIndex) {
    switch (pageIndex) {
      case 0:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => OrderPage(),
          settings: RouteSettings(name: 'OrderPage'),
        ));
        break;
      case 2:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => MenuPage(),
          settings: RouteSettings(name: 'MenuPage'),
        ));
        break;
    // 추가적인 case문을 여기에 추가해서 다른 버튼에 대한 페이지로의 이동을 처리할 수 있습니다.
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardDeviceWidth = 500;
    final standardDeviceHeight = 350;

    return DefaultLayout(
      customAppBarBottom: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.03 * (deviceHeight / standardDeviceHeight)),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.04 * (deviceHeight / standardDeviceHeight),
          color: PRIMARY_COLOR,
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    navigateToPage(0);
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFD9D9D9)),
                    ),
                    child: Center(
                      child: Text(
                        "주문접수",
                        style: TextStyle(
                            fontSize: 13.5 * (deviceWidth / standardDeviceWidth),
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    navigateToPage(1);
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFD9D9D9)),
                      color: Color(0xff1C386D),
                    ),
                    child: Center(
                      child: Text(
                        "매장관리",
                        style: TextStyle(
                            fontSize: 13.5 * (deviceWidth / standardDeviceWidth),
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    navigateToPage(2);
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFD9D9D9)),

                    ),
                    child: Center(
                      child: Text(
                        "메뉴관리",
                        style: TextStyle(
                            fontSize: 13.5 * (deviceWidth / standardDeviceWidth),
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 70 * (deviceWidth / standardDeviceWidth),
            color: Color(0xFFD9D9D9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedButtonIndex = 0;
                    });
                  },
                  child: Container(
                    width: 70 * (deviceWidth / standardDeviceWidth),
                    height: 30 * (deviceHeight / standardDeviceHeight),
                    color: selectedButtonIndex == 0 ? Color(0xFFFFFFFF) : Color(0xFF828282),
                    padding: EdgeInsets.all(4),
                    child: Center(
                      child: Text(
                        "마이페이지",
                        style: TextStyle(
                          fontSize: 12 * (deviceWidth / standardDeviceWidth),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30 * (deviceHeight / standardDeviceHeight)),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedButtonIndex = 1;
                    });
                  },
                  child: Container(
                    width: 70 * (deviceWidth / standardDeviceWidth),
                    height: 30 * (deviceHeight / standardDeviceHeight),
                    color: selectedButtonIndex == 1 ? Color(0xFFFFFFFF) : Color(0xFF828282),
                    padding: EdgeInsets.all(4),
                    child: Center(
                      child: Text(
                        "리뷰 보기",
                        style: TextStyle(
                          fontSize: 12 * (deviceWidth / standardDeviceWidth),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30 * (deviceHeight / standardDeviceHeight)),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedButtonIndex = 2;
                    });
                  },
                  child: Container(
                    width: 70 * (deviceWidth / standardDeviceWidth),
                    height: 30 * (deviceHeight / standardDeviceHeight),
                    color: selectedButtonIndex == 2 ? Color(0xFFFFFFFF) : Color(0xFF828282),
                    padding: EdgeInsets.all(4),
                    child: Center(
                      child: Text(
                        "가게 정보 수정",
                        style: TextStyle(
                          fontSize: 10 * (deviceWidth / standardDeviceWidth),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: buildRightContent(),
          ),
        ],
      ),
    );
  }
}
