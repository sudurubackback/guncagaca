import 'package:flutter/material.dart';
import 'package:guncagaca/common/const/colors.dart';

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
        title: Text(
          title!,
        ),
        foregroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart, color: PRIMARY_COLOR, size: 28.0),
            onPressed: () {
              FocusScope.of(context).unfocus();

              // 장바구니 아이콘 클릭 시 수행될 로직 작성
            },
          ),
        ],
      );
    }
  }
}
