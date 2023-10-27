import 'package:flutter/material.dart';

import '../../common/const/colors.dart';
import '../../common/layout/default_layout.dart';

import '../view/noti_screen.dart';

class NotiIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> dummyNotifications = [
      {
        "id": 1,
        "title": "새로운 알림",
        "message": "이것은 첫 번째 알림입니다.",
      },
      {
        "id": 2,
        "title": "두 번째 알림",
        "message": "두 번째 알림 메시지입니다.",
      },
      {
        "id": 3,
        "title": "근카가카 구미인동점",
        "message": "주문이 접수 되었습니다.",
      },
      {
        "id": 3,
        "title": "근카가카 구미인동점",
        "message": "주문이 접수 되었습니다.",
      },
      {
        "id": 3,
        "title": "근카가카 구미인동점",
        "message": "주문이 접수 되었습니다.",
      },
      {
        "id": 3,
        "title": "근카가카 구미인동점",
        "message": "주문이 접수 되었습니다.",
      },
      {
        "id": 3,
        "title": "근카가카 구미인동점",
        "message": "주문이 접수 되었습니다.",
      },
      {
        "id": 3,
        "title": "근카가카 구미인동점",
        "message": "주문이 접수 되었습니다.",
      },
      {
        "id": 3,
        "title": "근카가카 구미인동점",
        "message": "주문이 접수 되었습니다.",
      },
      {
        "id": 3,
        "title": "근카가카 구미인동점",
        "message": "주문이 접수 되었습니다.",
      },
      // 추가적인 알림 데이터를 필요에 따라 추가할 수 있습니다.
    ];

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
                  child: NotiScreen(notifications: dummyNotifications),
                ),
              ),
            );
          },
        ),

      ],
    );
  }
}
