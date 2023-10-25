import 'package:flutter/material.dart';
import 'package:guncagaca/common/view/root_tab.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '주문 내역',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0, // 그림자 효과를 없앰
        bottom: PreferredSize(
          child: Container(
            color: Color(0xff9B5748), // 갈색 선
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(1.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text('주문 내역 화면'),
            ),
          ],
        ),
      ),
    );
  }
}
