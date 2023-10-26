import 'package:flutter/material.dart';
import 'package:guencagaca_onwer/common/layout/default_layout.dart';
import 'package:guencagaca_onwer/store/screen/mypage.dart';
import 'package:guencagaca_onwer/store/screen/reviewpage.dart';
import 'package:guencagaca_onwer/store/screen/infopage.dart';

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
      // case 0:
      //   Navigator.of(context).push(PageRouteBuilder(
      //     pageBuilder: (context, animation, secondaryAnimation) => OrderPage(),
      //     settings: RouteSettings(name: 'OrderPage'),
      //   ));
      //   break;
      // case 2:
      //   Navigator.of(context).push(PageRouteBuilder(
      //     pageBuilder: (context, animation, secondaryAnimation) => MenuPage(),
      //     settings: RouteSettings(name: 'MenuPage'),
      //   ));
      //   break;
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
                  // navigateToPage(0);
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
                onTap: () {},
                child: Container(
                  width: 250,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF828282)),
                    color: Color(0xFF831800),
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
                  // navigateToPage(2);
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
                        "마이페이지",
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
                        "리뷰 보기",
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
                      selectedButtonIndex = 2;
                    });
                  },
                  child: Container(
                    width: 170,
                    height: 50,
                    color: selectedButtonIndex == 2 ? Color(0xFF831800) : Color(0xFF828282),
                    padding: EdgeInsets.all(4),
                    child: Center(
                      child: Text(
                        "가게 정보 수정",
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
