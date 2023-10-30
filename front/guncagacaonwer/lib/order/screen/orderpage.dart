import 'package:flutter/material.dart';
import 'package:guncagacaonwer/common/layout/default_layout.dart';
import 'package:guncagacaonwer/menu/screen/menupage.dart';
import 'package:guncagacaonwer/order/screen/ordercompletepage.dart';
import 'package:guncagacaonwer/order/screen/orderprocessingpage.dart';
import 'package:guncagacaonwer/order/screen/ordertrackingpage.dart';
import 'package:guncagacaonwer/order/screen/orderwaitingpage.dart';
import 'package:guncagacaonwer/store/screen/storepage.dart';

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
    return DefaultLayout(
      customAppBarBottom: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
        child: Container(
          color: Color(0xFF626262),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                },
                child: Container(
                  width: 250,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF828282)),
                    color: Color(0xFF831800),
                  ),
                  child: Center(
                    child: Text(
                      "주문접수",
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  navigateToPage(1);
                },
                child: Container(
                  width: 250,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF828282)),
                  ),
                  child: Center(
                    child: Text(
                      "매장관리",
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  navigateToPage(2);
                },
                child: Container(
                  width: 250,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF828282)),
                  ),
                  child: Center(
                    child: Text(
                      "메뉴관리",
                      style: TextStyle(
                        fontSize: 28,
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
            width: 130,
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
                    width: 130,
                    height: 130,
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
                    width: 130,
                    height: 130,
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
                    width: 130,
                    height: 130,
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
                    width: 130,
                    height: 130,
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
          Expanded(
            child: buildRightContent(),
          ),
        ],
      ),
    );
  }
}
