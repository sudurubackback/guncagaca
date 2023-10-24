import 'package:flutter/material.dart';

class OrderComponent extends StatelessWidget {





  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
              top: 70.0,
              left: 40.0,
              right: 40.0,
              bottom: 30.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '주문내역',
                    style: TextStyle(fontSize: 29.0),
                    textAlign: TextAlign.center,
                  ),

                ),


              ],
            ),
          ),
          Container(
            color: Color(0xff9B5748),
            height: 2.0,
          ),
          ]
        )
    );
  }
}