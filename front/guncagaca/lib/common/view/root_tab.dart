import 'package:guncagaca/common/const/colors.dart';
import 'package:guncagaca/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:guncagaca/home/view/home_screen.dart';

import 'package:guncagaca/order/view/order_view.dart';

import '../../kakao/main_view_model.dart';
import '../../mypage/component/mypage_component.dart';

class RootTab extends StatefulWidget {
  final int initialIndex;
  final MainViewModel mainViewModel;

  const RootTab({Key? key, this.initialIndex = 1, required this.mainViewModel}) : super(key: key);

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
    controller = TabController(initialIndex: widget.initialIndex, length: 3, vsync: this);
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
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [

          OrderView(mainViewModel: widget.mainViewModel,),
          HomeScreen(mainViewModel: widget.mainViewModel,),
          MypageComponent(mainViewModel: widget.mainViewModel,),
        ],
      ),
        mainViewModel: widget.mainViewModel,
    );
  }
}
