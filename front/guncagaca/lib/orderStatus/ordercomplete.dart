
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guncagaca/common/const/colors.dart';

import '../kakao/main_view_model.dart';
import '../order/view/order_view.dart';

class OrderCompletePage extends StatefulWidget {
  final MainViewModel mainViewModel;

  const OrderCompletePage({required this.mainViewModel});

  @override
  _OrderCompletePageState createState() => _OrderCompletePageState();
}

class _OrderCompletePageState extends State<OrderCompletePage> {

  Widget _buildTitleText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
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
          textAlign: TextAlign.center,
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
          padding: EdgeInsets.only(top: 20.0),
          child: IconButton(
            icon: Icon(Icons.close),
            iconSize: 30.0,
            color: Color(0xff000000),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        color: Color(0xfff8e9d7),
        child: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTitleText("접수 완료!"),
            Container(
              width: 350,
              height: 350,
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Image.asset(
                'assets/image/main_img.png',
                fit: BoxFit.contain,
              ),
            ),
          _buildSubText("접수가 완료되었습니다.\n예상 준비 시간은 약 00분입니다.\n맛있게 조리해서 준비해둘게요.\n조금만 기다려 주세요! \n주문사항은 주문내역에서 확인하실 수 있습니다."),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.08,
              padding: EdgeInsets.only(left: 30.0, right: 50.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: PRIMARY_COLOR,
                  width: 2.0,
                ),
                color: PRIMARY_COLOR,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: InkWell(
                onTap: () {
                  Get.to(() => OrderView(mainViewModel: widget.mainViewModel,)
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