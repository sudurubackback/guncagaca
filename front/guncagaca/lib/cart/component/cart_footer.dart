import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:guncagaca/pay/pay.dart';

import '../../common/const/colors.dart';
import '../../kakao/main_view_model.dart';
import '../controller/cart_controller.dart';

class CartFooter extends StatelessWidget {
  final MainViewModel mainViewModel;
  final CartController cartController = Get.find();

 CartFooter({required this.mainViewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 10)],
        border: Border(top: BorderSide(color: Colors.grey[200]!, width: 1.0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 20.0),
              Expanded(
                flex: 2,
                child: Obx(() => DropdownButton<int>(
                  isExpanded: true,
                  value: cartController.selectedTime.value,
                  items: [10, 20, 30, 40, 50, 60].map((time) {
                    return DropdownMenuItem(
                      child: Text(time == 60 ? "$time분 이상" : "$time분"),
                      value: time,
                    );
                  }).toList(),
                  onChanged: (value) {
                    cartController.setSelectedTime(value!);
                  },
                )),
              ),
              SizedBox(width: 20.0),
              Expanded(
                flex: 3,
                child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("포장"),
                    Radio<String>(
                      activeColor: PRIMARY_COLOR,
                      value: "포장",
                      groupValue: cartController.selectedOption.value,
                      onChanged: (value) {
                        cartController.setSelectedOption(value!);
                      },
                    ),
                    Text("매장"),
                    Radio<String>(
                      activeColor: PRIMARY_COLOR,
                      value: "매장",
                      groupValue: cartController.selectedOption.value,
                      onChanged: (value) {
                        cartController.setSelectedOption(value!);
                      },
                    ),
                  ],
                )),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("결제 금액 :"),
              SizedBox(width: 4.0),
              Obx(() => Text("${cartController.totalPrice}원")),
            ],
          ),
          SizedBox(height: 8.0),
          Builder(
            builder: (context) {
              return Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: PRIMARY_COLOR,
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                  ),
                  onPressed: () {
                    PaymentService(mainViewModel: mainViewModel).bootpay(context);
                  },
                  child: Text("결제하기"),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}


