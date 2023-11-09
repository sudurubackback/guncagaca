
import 'package:flutter/material.dart';

import '../kakao/main_view_model.dart';
import 'order_page.dart';

class CompletePage extends StatefulWidget {
  final MainViewModel mainViewModel;

  const CompletePage ({required this.mainViewModel});

  @override
  _CompletePageState createState() => _CompletePageState();
}

class _CompletePageState extends State<CompletePage> {

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
            _buildTitleText("준비 완료!"),
            Container(
              width: 350,
              height: 350,
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Image.asset(
                'assets/image/coffeelove.png',
                fit: BoxFit.contain,
              ),
            ),
          _buildSubText("오래 기다리셨습니다!\n주문하신 음식이모두 완성되었습니다.\n식기 전에 찾아가 주세요!\n주문사항은 주문내역에서 확인하실 수 있습니다."),
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
                    MaterialPageRoute(builder: (context) => OrderPage(mainViewModel: widget.mainViewModel,)),
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