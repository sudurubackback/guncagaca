import 'package:flutter/material.dart';
import 'order.dart';
import 'mypage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int current_index = 1;

  List body_item = [
    OrderPage(),
    Text("홈화면"),
    Mypage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: body_item.elementAt(current_index),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: current_index,
        onTap: (index) {
          setState(() {
            current_index = index;
          });
        },
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
        selectedItemColor: Color(0xff9B5748),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.shifting,
      ),

      floatingActionButton: current_index == 0
          ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CompletePage()), // OrderWait 페이지로 이동
          );
        },
        child: Icon(Icons.arrow_forward),
      )
          : null,
    );
  }
}
