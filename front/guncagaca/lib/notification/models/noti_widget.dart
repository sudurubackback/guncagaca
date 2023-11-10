import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guncagaca/common/const/colors.dart';
import 'package:guncagaca/notification/view/noti_screen.dart';

import '../../kakao/main_view_model.dart';

class NotiIconWidget extends StatelessWidget {
  final MainViewModel mainViewModel;

  const NotiIconWidget({required this.mainViewModel});

  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.topRight,
      children: [
        IconButton(
          icon: Icon(Icons.add_alert, color: PRIMARY_COLOR, size: 28.0),
          onPressed: () {
            FocusScope.of(context).unfocus();
            Get.to(() => NotiScreen(mainViewModel: mainViewModel,)
            );
          },
        ),

      ],
    );
  }
}
