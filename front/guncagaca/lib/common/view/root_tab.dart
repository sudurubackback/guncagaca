import 'package:guncagaca/common/const/colors.dart';
import 'package:guncagaca/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:guncagaca/home/view/home_screen.dart';
import 'package:provider/provider.dart';

import '../../home/component/map_provider.dart';
import 'package:guncagaca/mypage/view/mypage_view.dart';
import 'package:guncagaca/order/view/order_view.dart';

class RootTab extends StatefulWidget {
  final int initialIndex;
  const RootTab({Key? key, this.initialIndex = 1}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin{
  late TabController controller;

  int current_index = 1;
  final List<String> tabTitles = ['주문내역', '근카 ? 가카 !', '마이페이지'];

  @override
  void initState() {
    super.initState();
    current_index = widget.initialIndex;
    controller = TabController(initialIndex: widget.initialIndex, length: 3, vsync: this); // initialIndex를 사용
    controller.addListener((tabListener));
  }
  @override
  void dispose() {
    controller.removeListener(tabListener);

    super.dispose();
  }

  void tabListener() {
    setState(() {
      current_index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title : tabTitles[current_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: current_index,
        onTap:(int index) {
          FocusScope.of(context).unfocus();

          controller.animateTo(index);
        },
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_chart),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility),
            label: 'Mypage',
          ),
        ],
      ),
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(), // 상하로만 스크롤
        controller: controller,
        children: [

          OrderView(),
          ChangeNotifierProvider<MapProvider>(
            create: (context) => MapProvider(), // MapProvider의 인스턴스 생성 로직에 따라 적절히 수정해야 합니다.
            child: HomeScreen(),
          ),
          MypageView(),
        ],
      ),
    );
  }
}
