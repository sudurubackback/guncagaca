import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:guncagaca/common/const/colors.dart';

import '../../store/models/menu.dart';
import '../controller/noti_controller.dart';
import 'noti_item.dart';

class CartList extends StatelessWidget {
  final NotiController notiController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (notiController.notiItems.isEmpty) {
        return Center(child: Text("알림함이 비어있습니다."));
      }

      return Column(
        children: [
          Divider(color: PRIMARY_COLOR, thickness: 4.0,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "가게이름", // 예시로 넣은 가게이름. 실제 데이터로 대체 필요.
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(color: PRIMARY_COLOR, thickness: 4.0,),
          Expanded(
            child: ListView.builder(
              itemCount: notiController.notiItems.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    CartItem(item: notiController.notiItems[index]),  // 여러분의 CartItem 위젯
                    Divider(color: Colors.grey, thickness: 1.0,),  // 마지막 아이템에는 구분선을 추가하지 않음
                  ],
                );
              },
            ),
          )
        ],
      );
    });
  }
}

