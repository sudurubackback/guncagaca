import 'package:flutter/material.dart';
import 'package:guncagaca/common/const/colors.dart';

class OrderDetailList extends StatelessWidget {
  final List<dynamic> orderMenus;

  OrderDetailList({required this.orderMenus});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: orderMenus.map((entry) {
        String menuName = entry['menuName'];
        List<dynamic> options = entry['options'];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: MediaQuery.of(context).size.width * 0.05),
        child: Text(menuName,style: TextStyle(fontSize: 18.0,
          height: 1.5,color: PRIMARY_COLOR)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: options.map((option) {
                String optionName = option['optionName'];
                String selectedOption = option['selectedOption'];

                return Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.005, left: MediaQuery.of(context).size.width * 0.05),
                  child: Text(
                    "$optionName: $selectedOption",
                    style: TextStyle(fontSize: 15.0, height: 1.5),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
            Divider(
              color: Color(0xffD9D9D9),
              thickness: 1,
            ),
          ],
        );
      }).toList(),
    );
  }
}
