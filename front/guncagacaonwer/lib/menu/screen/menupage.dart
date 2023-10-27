import 'package:flutter/material.dart';
import 'package:guncagacaonwer/common/layout/default_layout.dart';
import 'package:guncagacaonwer/menu/screen/menuallpage.dart';
import 'package:guncagacaonwer/menu/screen/menuregistrationpage.dart';
// import 'package:guncagacaonwer/order/screen/orderpage.dart';
import 'package:guncagacaonwer/store/screen/storepage.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int selectedButtonIndex = 0;

  Widget buildRightContent() {
    switch (selectedButtonIndex) {
      case 0:
        return MenuAllPage();
    // return Center(child: Text("메뉴 전체보기의 내용"));
      case 1:
        return MenuRegistrationPage();
    // return Center(child: Text("메뉴 신규 등록의 내용"));
      default:
        return Center(child: Text("나머지 영역의 내용"));
    }
  }

  void navigateToPage(int pageIndex) {
    switch (pageIndex) {
      case 0:
        // Navigator.of(context).push(PageRouteBuilder(
        //   pageBuilder: (context, animation, secondaryAnimation) => OrderPage(),
        //   settings: RouteSettings(name: 'OrderPage'),
        // ));
        // break;
      case 1:
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => StorePage(),
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
                  navigateToPage(0);
                },
                child: Container(
                  width: 250,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF828282)),
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
            width: 170,
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
                    width: 170,
                    height: 50,
                    color: selectedButtonIndex == 0 ? Color(0xFF831800) : Color(0xFF828282),
                    padding: EdgeInsets.all(4),
                    child: Center(
                      child: Text(
                        "메뉴 전체보기",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedButtonIndex = 1;
                    });
                  },
                  child: Container(
                    width: 170,
                    height: 50,
                    color: selectedButtonIndex == 1 ? Color(0xFF831800) : Color(0xFF828282),
                    padding: EdgeInsets.all(4),
                    child: Center(
                      child: Text(
                        "메뉴 신규 등록",
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
