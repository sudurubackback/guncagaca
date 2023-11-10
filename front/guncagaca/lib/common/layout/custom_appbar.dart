import 'package:flutter/material.dart';
import 'package:guncagaca/cart/models/cart_widget.dart';
import 'package:guncagaca/notification/models/noti_widget.dart';
import 'package:guncagaca/kakao/main_view_model.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final MainViewModel mainViewModel;

  CustomAppBar({required this.title, required this.mainViewModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.1),
          Flexible(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Row(
            children: [
              CartIconWidget(mainViewModel: mainViewModel),
              NotiIconWidget(mainViewModel: mainViewModel),
            ],
          ),
        ],
      ),
      foregroundColor: Colors.black,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
