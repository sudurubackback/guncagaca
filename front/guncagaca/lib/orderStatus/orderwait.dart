
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/const/colors.dart';
import '../kakao/main_view_model.dart';
import '../order/view/order_view.dart';

class OrderWaitPage extends StatefulWidget {
  final MainViewModel mainViewModel;

  const OrderWaitPage({required this.mainViewModel});

  @override
  _OrderWaitPageState createState() => _OrderWaitPageState();
}

class _OrderWaitPageState extends State<OrderWaitPage> {

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
          textAlign: TextAlign.center,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BACK_COLOR,
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
        color: BACK_COLOR,
        child: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTitleText("주문대기 중"),
            Container(
              width: 350,
              height: 350,
              padding: EdgeInsets.symmetric(vertical: 20.0), // 위아래로 패딩을 줍니다
              child: Image.asset(
                'assets/image/main_img.png',
                fit: BoxFit.contain,
              ),
            ),
          _buildSubText("가게에서 주문을 확인 중입니다.\n가게 사정에 따라 주문이 취소될 수 있습니다.\n접수가 완료되면 알려드릴게요!\n주문사항은 주문내역에서 확인하실 수 있습니다."),
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
                  Get.to(() => OrderView(mainViewModel: widget.mainViewModel,) // OrderPage로 이동
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