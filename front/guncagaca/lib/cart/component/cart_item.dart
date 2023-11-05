import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:guncagaca/order/models/order_option.dart';
import '../../menu/menu.dart';
import '../../menu/option.dart';
import '../../order/models/order_menu.dart';
import '../controller/cart_controller.dart';

class CartItem extends StatelessWidget {
  final OrderMenu item;

  CartItem({required this.item});

  @override
  Widget build(BuildContext context) {
    CartController controller = Get.find<CartController>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  // 장바구니에서 삭제
                  controller = Get.find<CartController>();
                  controller.removeFromCart(item);
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 메뉴 사진
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(item.img),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: _buildOptionList(item.selectedOptions ?? []),
              ),
              SizedBox(width: 20), // 추가된 코드: 가격과 버튼 사이의 간격
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(()=> Text('₩${item.totalPrice * (item.quantity.value)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                  Row(
                    children: [
                      IconButton(icon: Icon(Icons.remove), onPressed: () {
                        Get.find<CartController>().decreaseQuantity(item);
                      }),
                      Obx(() => Text('${item.quantity.value}', style: TextStyle(fontSize: 18))),
                      IconButton(icon: Icon(Icons.add), onPressed: () {
                        Get.find<CartController>().increaseQuantity(item);
                      }),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptionList(List<OrderOption> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: options.map((option) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text('- ${option.optionName} : ${option.selectedOption}', style: TextStyle(color: Colors.grey)),
        );
      }).toList(),
    );
  }

}

