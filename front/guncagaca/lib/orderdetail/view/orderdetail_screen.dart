import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guncagaca/common/const/colors.dart';
import 'package:guncagaca/common/view/custom_appbar.dart';
import 'package:intl/intl.dart';

import '../../common/layout/default_layout.dart';
import '../../kakao/main_view_model.dart';
import '../../store/view/store_detail_screen.dart';
import '../component/orderdetail_list.dart';

class OrderDetailScreen extends StatefulWidget {
  final Map<String, dynamic> orderHistory;
  final MainViewModel mainViewModel;


  OrderDetailScreen({required this.orderHistory, required this.mainViewModel});

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
  late String orderTime;

  @override
  void initState() {
    super.initState();
    orderTime = formatDateTime(widget.orderHistory['orderTime']);
  }

  String formatDateTime(String datetimeStr) {
    DateTime datetime = DateTime.parse(datetimeStr);

    // 날짜 및 시간 형식
    String year = datetime.year.toString();
    String month = datetime.month.toString().padLeft(2, '0');
    String day = datetime.day.toString().padLeft(2, '0');
    String weekday = DateFormat('EEEE', 'ko_KR').format(datetime).substring(0, 1);
    String period = datetime.hour < 12 ? "오전" : "오후";
    String hour = (datetime.hour <= 12 ? datetime.hour : datetime.hour - 12).toString().padLeft(2, '0');
    String minute = datetime.minute.toString().padLeft(2, '0');

    return "$year년 $month월 $day일 ($weekday) $period $hour:$minute";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
        child: CustomAppbar(title: '주문내역', imagePath: null,)
        ),
        body:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬 추가
              children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: MediaQuery.of(context).size.width * 0.05, right:MediaQuery.of(context).size.width * 0.05 ), // 위아래 패딩 값 설정
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.orderHistory["status"],
                        style: TextStyle(
                        color: PRIMARY_COLOR,
                    fontSize: 17.0,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: widget.orderHistory['takeoutYn'] ? Colors.green : Colors.red,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.02,
                    vertical: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: Text(
                    widget.orderHistory['takeoutYn'] ? '포장' : '매장',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: MediaQuery.of(context).size.width * 0.05), // 위아래 패딩 값 설정
            child: Text(
              widget.orderHistory['store']['cafeName'],
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: MediaQuery.of(context).size.width * 0.05), // 위아래 패딩 값 설정
            child: Text(
              widget.orderHistory['menus'].length > 1
              ? widget.orderHistory['menus'][0]['menuName']+
                  " 외 " +
                  (widget.orderHistory['menus'].length-1)
                      .toString() + "개 "
              : widget.orderHistory['menus'][0]['menuName'],
              style: TextStyle(fontSize: 17.0,
                color: PRIMARY_COLOR,
                ),
            ),
          ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: MediaQuery.of(context).size.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "주문 일시: $orderTime",
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(height: 10.0), // 주문 일시와 주문번호 사이의 간격을 조정
                      Text(
                        "주문 번호: ${widget.orderHistory['id']}",
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ],
                  ),
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
                          title: widget.orderHistory['store']['cafeName'],
                          child: StoreDetailScreen(storeId: widget.orderHistory['store']['storeId'], mainViewModel: widget.mainViewModel,) ,
                      mainViewModel: widget.mainViewModel,),
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

          OrderDetailList(orderMenus: widget.orderHistory['menus']),

          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03, left: MediaQuery.of(context).size.width * 0.05), // 위아래 패딩 값 설정
            child: Text("결제 금액 : ${widget.orderHistory['price']}원",
              style: TextStyle(fontSize: 20.0),)
          ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: MediaQuery.of(context).size.width * 0.05, bottom: MediaQuery.of(context).size.height * 0.04, ),
                  child: Text(
                    "결제 방법 : ${widget.orderHistory['payMethod']}",
                    style: TextStyle(fontSize: 17.0),
                  ),
                ),

        ],
      ),
      )
    );
  }
}
