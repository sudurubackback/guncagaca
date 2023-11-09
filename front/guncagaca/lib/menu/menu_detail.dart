
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:guncagaca/common/const/colors.dart';
import 'package:guncagaca/order/models/order_option.dart';

import '../cart/controller/cart_controller.dart';
import '../order/models/order_menu.dart';
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
  

  void _showCustomDialog(OrderMenu order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 10,
          backgroundColor: Colors.transparent,
          child: _buildDialogContents(order),
        );
      },
    );
  }

  Widget _buildDialogContents(OrderMenu order) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "장바구니 비우기",
                style: TextStyle(
                  color: PRIMARY_COLOR,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text("장바구니에는 한 가게의\n상품만 담을 수 있습니다.\n\n장바구니를 비우고 새로운\n상품을 담겠습니까?",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                ),),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      child: Text(
                        "아니요",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text("예",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        final CartController controller = Get.find<CartController>();
                        controller.cartItems.clear();
                        controller.cartItems.add(order);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

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
                            selectedOptionPrices[menuIndex] = price;
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
            var newOrder = OrderMenu(
              menuId: widget.menu.menuId,
                name: widget.menu.name,
                initPrice: widget.menu.initPrice,
                totalPrice: total.toInt(),
                img: widget.menu.imagePath,
                storeName: widget.storeName,
                category: widget.menu.category,
                storeId: widget.menu.storeId,
                selectedOptions: selectedOptions,
            );
            if (controller.cartItems.isNotEmpty && controller.cartItems[0].storeName != widget.storeName) {
              _showCustomDialog(newOrder);
            } else {
              controller.addToCart(newOrder);
              print(newOrder);
              Navigator.pop(context);
            }
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

