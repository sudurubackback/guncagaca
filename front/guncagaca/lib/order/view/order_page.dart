import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guncagaca/order/component/order_component.dart';

import '../../menu/menu_detail.dart';


class OrderPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Color(0xfff8e9d7),
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0, // 밑 줄 제거
          automaticallyImplyLeading: false, // leading 영역을 자동으로 생성하지 않도록 설정
          flexibleSpace: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 20),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30.0,
                    color: Color(0xff000000),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only( top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '주문내역',
                        style: TextStyle(color: Colors.black, fontSize: 29.0),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 20),
                  child: Opacity(
                    opacity: 0.0, // 아이콘을 투명하게 만듭니다.
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Color(0xff000000),
                      onPressed: () {
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(2.0),
            child: Container(
              color: Color(0xff9B5748),
              height: 2.0,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: OrderList(),
          ),
        ],
      ),
    );

  }
}