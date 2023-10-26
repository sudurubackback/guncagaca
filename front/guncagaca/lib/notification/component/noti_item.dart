import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../store/models/menu.dart';
import '../controller/noti_controller.dart';

class CartItem extends StatelessWidget {
  final Menu item;

  CartItem({required this.item});

  @override
  Widget build(BuildContext context) {
    final NotiController controller = Get.find<NotiController>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                  NotiController controller = Get.find<NotiController>();
                  controller.removeFromNoti(item);
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
                    image: AssetImage(item.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text("• ICE (2잔) 보통"),
              ),
              SizedBox(width: 20), // 추가된 코드: 가격과 버튼 사이의 간격
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(()=> Text('₩${item.price * (controller.itemQuantities[item] ?? 1)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                  Row(
                    children: [
                      IconButton(icon: Icon(Icons.remove), onPressed: () {
                        Get.find<NotiController>().decreaseQuantity(item);
                      }),
                      Obx(() => Text('${controller.itemQuantities[item] ?? 1}', style: TextStyle(fontSize: 18))),
                      IconButton(icon: Icon(Icons.add), onPressed: () {
                        Get.find<NotiController>().increaseQuantity(item);
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
}

