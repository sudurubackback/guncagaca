import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:guncagaca/common/const/colors.dart';
import 'package:guncagaca/order/models/order_option.dart';

import '../cart/controller/cart_controller.dart';
import '../order/models/order.dart';
import 'menu.dart';
import 'menu_option.dart';
import 'option.dart';
import 'option_list.dart';

class DetailPage extends StatefulWidget {
  final Menu menu;
  final String storeName;

  DetailPage({required this.menu, required this.storeName});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<DetailPage> {
  late List<int> selectedOptionIndices;
  late List<int> selectedOptionPrices;

  num getOptionPrice(List<Option> options, int selectedIndex) {
    if (options.isNotEmpty && selectedIndex < options.length && selectedIndex != -1) {
      return options[selectedIndex].price;
    }
    return 0;
  }

  num calculateTotalPrice() {
    num total = widget.menu.initPrice;

    for (int i = 0; i < widget.menu.options.length; i++) {
      if (selectedOptionIndices[i] != -1) {
        total += getOptionPrice(widget.menu.options[i].subOptions, selectedOptionIndices[i]);
      }
    }

    return total;
  }

  @override
  void initState() {
    selectedOptionIndices = List.filled(widget.menu.options.length, -1);
    selectedOptionPrices = List.filled(widget.menu.options.length, -1);
    super.initState();
    // 모든 옵션을 첫 번째 서브옵션으로 초기화
  }

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.find<CartController>();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: BACK_COLOR,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Hero (
      tag: "store-menu",
        flightShuttleBuilder: (
            BuildContext flightContext,
            Animation<double> animation,
            HeroFlightDirection flightDirection,
            BuildContext fromHeroContext,
            BuildContext toHeroContext,
            ) {
          return FadeTransition(
            opacity: animation,
            child: flightDirection == HeroFlightDirection.pop
                ? fromHeroContext.widget
                : toHeroContext.widget,
          );
        },
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        widget.menu.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.2,
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: PRIMARY_COLOR,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.menu.name),
                          Text(widget.menu.initPrice.toString()),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          widget.menu.description,
                          style: TextStyle(fontSize: 15, color: Color(0xffD9A57F)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Container(
                  color: Color(0xffD9D9D9),
                  height: 2.0,
                ),
                ...List.generate(widget.menu.options.length, (menuIndex) {
                  MenuOption currentOption = widget.menu.options[menuIndex];

                  return Column(
                    children: [
                      OptionList(menuOption: currentOption,
                        onOptionSelected: (index, price) {
                          setState(() {
                            selectedOptionIndices[menuIndex] = index;
                            selectedOptionPrices[menuIndex] = price;  // 가격 정보 저장
                          });
                        },),
                      if (menuIndex != widget.menu.options.length - 1)
                        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                      if (menuIndex != widget.menu.options.length - 1)
                        Container(
                          color: Color(0xffD9D9D9),
                          height: 2.0,
                        ),
                    ],
                  );
                }),
              ],
            ),
          ],
        ),
        bottomNavigationBar: _buildBottomBar(),
      )
    );
  }
  Widget _buildBottomBar() {
    final CartController controller = Get.find<CartController>();

    return Padding(
      padding: EdgeInsets.all(18.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.08,
        padding: EdgeInsets.only(left: 30.0, right: 30.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xffD9A57F),
            width: 2.0,
          ),
          color: Color(0xffD9A57F),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: InkWell(
          onTap: () {
            num total = widget.menu.initPrice;

            for (int i = 0; i < widget.menu.options.length; i++) {
              total += getOptionPrice(widget.menu.options[i].subOptions, selectedOptionIndices[i]);
            }

            List<OrderOption> selectedOptions = [];
            for (int i = 0; i < widget.menu.options.length; i++) {
              if (selectedOptionIndices[i] != -1) { // -1이 아닌 경우에만 추가
                String optionName = widget.menu.options[i].optionName;
                String selectedOptionLabel = widget.menu.options[i].subOptions[selectedOptionIndices[i]].label;
                selectedOptions.add(OrderOption(optionName: optionName, selectedOption: selectedOptionLabel));
              }
            }
            var newOrder = Order(
                name: widget.menu.name,
                totalPrice: total.toInt(),
                img: widget.menu.imagePath,
                storeName: widget.storeName,
                selectedOptions: selectedOptions,
            );
            controller.addToCart(newOrder);
            print(newOrder);
            Navigator.pop(context);
          },
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${calculateTotalPrice()}원',
                  style: TextStyle(fontSize: 15, color: Color(0xffffffff)),
                ),
                Text(
                  '담기',
                  style: TextStyle(fontSize: 15, color: Color(0xffffffff)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

