import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:guncagaca/login/loginpage.dart';

import '../order/order.dart';

class OrderCancellPage extends StatefulWidget {

  @override
  _OrderCancellPageState createState() => _OrderCancellPageState();
}

class _OrderCancellPageState extends State<OrderCancellPage> {

  Widget _buildTitleText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildSubText(String text) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 35, left: MediaQuery.of(context).size.width * 0.1, right: MediaQuery.of(context).size.width * 0.1),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
            height: 1.8
          ),
          textAlign: TextAlign.center, // 가운데 정렬 추가
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff8e9d7),
        leading: Padding(
          padding: EdgeInsets.only(top: 20.0), // 아이콘을 아래로 이동
          child: IconButton(
            icon: Icon(Icons.close),
            iconSize: 30.0,
            color: Color(0xff000000),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        elevation: 0, // 밑 줄 제거
      ),
      body: Container(
        color: Color(0xfff8e9d7),
        child: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTitleText("주문취소"),
            Container(
              width: 350,
              height: 350,
              padding: EdgeInsets.symmetric(vertical: 20.0), // 위아래로 패딩을 줍니다
              child: Image.asset(
                'assets/image/cancell.png',
                fit: BoxFit.contain,
              ),
            ),
          _buildSubText("정말 죄송합니다.\n고객님이 주문하신 음식이.\n____의 이유로 취소되었습니다.\n자세한 내용은 주문내역에서 확인하실 수 있습니다."),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.08,
              padding: EdgeInsets.only(left: 30.0, right: 50.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff9B5748),
                  width: 2.0,
                ),
                color: Color(0xff9B5748),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderPage()), // OrderPage로 이동
                  );
                },
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '주문내역 보기',
                        style: TextStyle(fontSize: 20,
                            color: Color(0xffffffff)),

                      ),

                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    ),

    );
  }
}