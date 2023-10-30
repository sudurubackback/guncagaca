import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guncagaca/common/const/colors.dart';
import 'dart:convert';

import '../../common/layout/default_layout.dart';
import '../../store/models/store.dart';
import '../../store/view/store_detail_screen.dart';
import '../component/orderdetail_list.dart';

class OrderDetailScreen extends StatefulWidget {
  final int id;



  OrderDetailScreen({required this.id});

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

// String _formatOrderMenus(Map<String, dynamic> orderMenus) {
//   String formattedMenus = "";
//
//   orderMenus.forEach((menu, options) {
//     formattedMenus += "$menu\n";
//
//     // 옵션을 개별적으로 줄바꿈
//     options.forEach((option) {
//       formattedMenus += "$option\n";
//     });
//
//     formattedMenus += "\n"; // 각 메뉴와 옵션 블록 사이에 빈 줄 추가
//   });
//
//   return formattedMenus;
// }



class _OrderDetailScreenState extends State<OrderDetailScreen> {
  List<Map<String, dynamic>> dummyOrders = [];

  @override
  void initState() {
    super.initState();
    loadDummyOrders();
  }

  void loadDummyOrders() async {
    try {
      String jsonString = await DefaultAssetBundle.of(context)
          .loadString('assets/json/order_dumi.json');
      dummyOrders = List<Map<String, dynamic>>.from(json.decode(jsonString));

    } catch (e) {
      print('Error decoding JSON: $e');
      // 예외가 발생한 경우 빈 리스트로 초기화합니다.
      dummyOrders = [];
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> orderData = dummyOrders.firstWhere(
          (order) => order["id"] == widget.id,
      orElse: () => Map<String, dynamic>.from({}),
    );

    ImageProvider? imageProvider;

    if (orderData["img"] != null && orderData["img"] is String) {
      imageProvider = NetworkImage(orderData["img"]);
    } else {
      imageProvider = AssetImage("assets/image/cafe.PNG");
    }

    Store store = Store(
      image: imageProvider,
      name: orderData["name"] ?? "이름 없음",
      distance: 2.5,
      rating: 4.5,
      reviewCount: 120,
      description: '맛있는 음식을 제공하는 식당입니다.',
    );

    if (orderData.isEmpty) {
      return Center(
        child: Text("해당 주문을 찾을 수 없습니다."),
      );
    }



    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Color(0xfff8e9d7),
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
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
                  padding: EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      const Text(
                        '주문내역',
                        style: TextStyle(color: Colors.black, fontSize: 29.0),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(width: 10.0),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 20),
                  child: Opacity(
                    opacity: 0.0,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Color(0xff000000),
                      onPressed: () {},
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
      body: orderData != null
          ? SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬 추가
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: MediaQuery.of(context).size.width * 0.05, right:MediaQuery.of(context).size.width * 0.05 ), // 위아래 패딩 값 설정
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${orderData["order_status"]}",
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 17.0,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: orderData['takeoutYn'] ? Colors.green : Colors.red,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.02,
                    vertical: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: Text(
                    orderData['takeoutYn'] ? '테이크아웃' : '매장',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: MediaQuery.of(context).size.width * 0.05), // 위아래 패딩 값 설정
            child: Text(
              "${orderData["name"]}",
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: MediaQuery.of(context).size.width * 0.05), // 위아래 패딩 값 설정
            child: Text(
              orderData['order_memu'][0].toString() +
                  " 외 " +
                  orderData['order_memu'].length
                      .toString() +
                  "개 ",
              style: TextStyle(fontSize: 17.0,
                ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: MediaQuery.of(context).size.width * 0.05), // 위아래 패딩 값 설정
            child:Text("주문 시간: ${orderData["time_history"]}",
              style: TextStyle(fontSize: 17.0),),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.03),
              width: MediaQuery.of(context).size.width * 0.85, // 버튼의 폭을 조절하세요 (원하는 크기로 설정)
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02),
                  backgroundColor: PRIMARY_COLOR,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: PRIMARY_COLOR, width: 2),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DefaultLayout(
                          title: store.name,
                          child: StoreDetailScreen(store: store)),
                    ),
                  );
                },
                child: Text("가게 상세 정보 보기"),
              ),
            ),
          ),
          Divider(
            color: Color(0xffD9D9D9),
            thickness: 1,
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: MediaQuery.of(context).size.width * 0.05), // 위아래 패딩 값 설정
            child: Text("메뉴",
              style: TextStyle(fontSize: 20.0,
                height: 1.5,),),
          ),

          OrderDetailList(orderMenus: orderData["order_memus"]),


          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03, left: MediaQuery.of(context).size.width * 0.05), // 위아래 패딩 값 설정
            child: Text("결제 금액 : ${orderData["order_prices"]}원",
              style: TextStyle(fontSize: 20.0),)
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05 ,)

        ],
      ),
      )
          : Center(
        child: Text("해당 주문을 찾을 수 없습니다."),
      ),
    );

  }
}
