import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guncagaca/notification/models/noti_widget.dart';

import '../../cart/models/cart_widget.dart';


class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final Widget? bottomNavigationBar;

  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    this.title,
    this.bottomNavigationBar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(context),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

      AppBar? renderAppBar(BuildContext context) {
        if (title == null) {
          return null;
        } else {

          return AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // 가운데 정렬을 위해 추가된 부분
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                // Container(), // 추가된 빈 컨테이너
                Center(
                  child: Text(
                    title!,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                Row(
                  children: [
                    CartIconWidget(),
                    NotiIconWidget(),
                  ],
                ),
              ],
            ),
            foregroundColor: Colors.black,
          );
        }
      }
    }

