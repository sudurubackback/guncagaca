import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../common/const/colors.dart';
import '../../common/layout/default_layout.dart';
import '../controller/noti_controller.dart';
import '../view/noti_screen.dart';

class NotiIconWidget extends StatelessWidget {
  final NotiController notiController = Get.find<NotiController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        IconButton(
          icon: Icon(Icons.add_alert, color: PRIMARY_COLOR, size: 28.0),
          onPressed: () {
            FocusScope.of(context).unfocus();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DefaultLayout(
                    child: NotiScreen()),
              ),
            );
          },
        ),
        Obx(() {
          if (notiController.notiItems.length == 0) {
            return SizedBox.shrink();
          }

          return Positioned(
            right: 8,
            top: 8,
            child: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.red,
              child: Text(
                notiController.notiItems.length.toString(),
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
