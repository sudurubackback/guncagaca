import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:guncagaca/common/const/colors.dart';
import 'package:guncagaca/review_create/reviewcreate_view.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  List<Map<String, dynamic>> dummyOderss = [];

  @override
  void initState() {
    super.initState();
    loadDummyOrders();
  }

  void loadDummyOrders() async {
    try {
      String jsonString = await DefaultAssetBundle.of(context)
          .loadString('assets/json/order_dumi.json');
      dummyOderss = List<Map<String, dynamic>>.from(json.decode(jsonString));
      print("여기입니다");
      print(dummyOderss);
      setState(() {}); // 상태를 업데이트하여 위젯을 다시 그립니다.
    } catch (e) {
      print('Error decoding JSON: $e');
    }
  }

  void _removeOrder(int index) {
    setState(() {
      dummyOderss.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return dummyOderss.isEmpty
        ? Center(
      child: Text(
        "주문내역이 없습니다.",
        style: TextStyle(fontSize: 18.0),
      ),
    )
        : ListView.builder(
      itemCount: dummyOderss.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == dummyOderss.length) {
          return SizedBox(height: 20);
        }

        return Container(
          margin: EdgeInsets.only(top: 15, left: 10, right: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xff9B5748),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ListTile(
            contentPadding:
            EdgeInsets.symmetric(vertical: 13.0, horizontal: 16.0),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          dummyOderss[index]['time_history'].toString(),
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                            width:
                            MediaQuery.of(context).size.width * 0.27),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: dummyOderss[index]['takeoutYn']
                                  ? Colors.green
                                  : Colors.red,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2),
                          child: Text(
                            dummyOderss[index]['takeoutYn']
                                ? '테이크아웃'
                                : '매장',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(
                            dummyOderss[index]['img'],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dummyOderss[index]['name'].toString() + ' ＞',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.width * 0.02,),
                        Text(
                          dummyOderss[index]['order_memu'][0].toString() +
                              " 외 " +
                              dummyOderss[index]['order_memu'].length
                                  .toString() +
                              "개 " +
                              dummyOderss[index]['order_prices'].toString() +
                              "원",
                          style: TextStyle(fontSize: 15.0),
                        ),

                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: dummyOderss[index]['reviewYn']
                              ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: BACK_COLOR, // 배경색 변경
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(color: PRIMARY_COLOR, width: 2)// 둥근 모서리 설정
                              ),
                            ),
                            onPressed: () {
                              // 리뷰 작성 완료 버튼 클릭 시 동작 추가
                            },
                            child: Text('리뷰 작성 완료',
                              style: TextStyle(color: Colors.black),),
                          )
                              : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: PRIMARY_COLOR, // 배경색 변경
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(color: PRIMARY_COLOR, width: 2), // 둥근 모서리 설정
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ReviewCreatePage()), // ReviewCreateScreen으로 이동
                              );
                            },
                            child: Text('리뷰 쓰기'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            onTap: () {
              // 알림을 눌렀을 때의 동작을 추가하세요.
            },
          ),
        );
      },
    );
  }
}
