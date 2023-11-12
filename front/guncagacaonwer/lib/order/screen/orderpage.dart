import 'package:flutter/material.dart';
import 'package:guncagacaonwer/common/layout/default_layout.dart';
import 'package:guncagacaonwer/menu/screen/menupage.dart';
import 'package:guncagacaonwer/order/screen/ordercompletepage.dart';
import 'package:guncagacaonwer/order/screen/orderprocessingpage.dart';
import 'package:guncagacaonwer/order/screen/ordertrackingpage.dart';
import 'package:guncagacaonwer/order/screen/orderwaitingpage.dart';
import 'package:guncagacaonwer/store/screen/storepage.dart';

import '../../common/const/colors.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int selectedButtonIndex = 0;

  Widget buildRightContent() {
    switch (selectedButtonIndex) {
      case 0:
        return OrderWaitingPage();
    // return Center(child: Text("메뉴 전체보기의 내용"));
      case 1:
        return OrderProcessingPage();
    // return Center(child: Text("메뉴 신규 등록의 내용"));
      case 2:
        return OrderCompletePage();
        // return Center(child: Text("메뉴 신규 등록의 내용"));
      case 3:
        return OrderTrackingPage();
        // return Center(child: Text("메뉴 신규 등록의 내용"));
      default:
        return Center(child: Text("나머지 영역의 내용"));
    }
  }

  void navigateToPage(int pageIndex) {
    switch (pageIndex) {
      case 1:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => StorePage(),
          settings: RouteSettings(name: 'StorePage'),
        ));
        break;
      case 2:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => MenuPage(),
          settings: RouteSettings(name: 'StorePage'),
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
                      color: Color(0xff1C386D),
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
          SingleChildScrollView(
            child: Container(
              width: 54 * (deviceWidth / standardDeviceWidth),
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
                      width: 54 * (deviceWidth / standardDeviceWidth),
                      height: 66.5 * (deviceHeight / standardDeviceHeight),
                      decoration: BoxDecoration(
                        color: selectedButtonIndex == 0 ? Color(0xFFFFFFFF) : Color(0xFFD9D9D9),
                        border: selectedButtonIndex == 0 ? null : Border.all(
                          color: Color(0xFF828282), // 외각선 색상
                          width: 0.5, // 외각선 두께
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "주문대기",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedButtonIndex = 1;
                      });
                    },
                    child: Container(
                      width: 54 * (deviceWidth / standardDeviceWidth),
                      height: 66.5 * (deviceHeight / standardDeviceHeight),
                      decoration: BoxDecoration(
                        color: selectedButtonIndex == 1 ? Color(0xFFFFFFFF) : Color(0xFFD9D9D9),
                        border: selectedButtonIndex == 1 ? null : Border.all(
                          color: Color(0xFF828282), // 외각선 색상
                          width: 0.5, // 외각선 두께
                        ),
                      ),
                      padding: EdgeInsets.all(4),
                      child: Center(
                        child: Text(
                          "처리중",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedButtonIndex = 2;
                      });
                    },
                    child: Container(
                      width: 54 * (deviceWidth / standardDeviceWidth),
                      height: 66.5 * (deviceHeight / standardDeviceHeight),
                      decoration: BoxDecoration(
                        color: selectedButtonIndex == 2 ? Color(0xFFFFFFFF) : Color(0xFFD9D9D9),
                        border: selectedButtonIndex == 2 ? null : Border.all(
                          color: Color(0xFF828282), // 외각선 색상
                          width: 0.5, // 외각선 두께
                        ),
                      ),
                      padding: EdgeInsets.all(4),
                      child: Center(
                        child: Text(
                          "주문완료",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedButtonIndex = 3;
                      });
                    },
                    child: Container(
                      width: 54 * (deviceWidth / standardDeviceWidth),
                      height: 66.5 * (deviceHeight / standardDeviceHeight),
                      decoration: BoxDecoration(
                        color: selectedButtonIndex == 3 ? Color(0xFFFFFFFF) : Color(0xFFD9D9D9),
                        border: selectedButtonIndex == 3 ? null : Border.all(
                          color: Color(0xFF828282), // 외각선 색상
                          width: 0.5, // 외각선 두께
                        ),
                      ),
                      padding: EdgeInsets.all(4),
                      child: Center(
                        child: Text(
                          "주문조회",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
