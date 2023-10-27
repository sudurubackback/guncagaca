import 'package:flutter/material.dart';
import 'package:guncagacaonwer/common/const/colors.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? customAppBarBottom;

  DefaultLayout({required this.child, this.customAppBarBottom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.04,
        backgroundColor: APPBAR_COLOR1,
        title: Text(
          "근카가카",
          style: TextStyle(fontSize: 30),
        ),
        bottom: customAppBarBottom,
      ),
      body: child,
    );
  }
}
