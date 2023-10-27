import 'package:flutter/material.dart';
import 'package:guncagaca/common/const/colors.dart';
import 'package:guncagaca/common/layout/default_layout.dart';
import 'package:guncagaca/notification/view/noti_screen.dart';
import 'dart:convert';
// import 'package:flutter/services.dart' show rootBundle; // 추가

class NotiIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> dummyNotifications = [];

    DefaultAssetBundle.of(context)
        .loadString('assets/json/noti_dumi.json')
        .then((String jsonString) {
      try {
        dummyNotifications = List<Map<String, dynamic>>.from(json.decode(jsonString));
      } catch (e) {
        print('Error decoding JSON: $e');
      }
    }).catchError((error) {
      print('Error loading JSON: $error');
    });

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
