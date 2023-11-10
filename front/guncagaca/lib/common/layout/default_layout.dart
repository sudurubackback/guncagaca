import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guncagaca/common/layout/custom_appbar.dart';
import 'package:guncagaca/notification/models/noti_widget.dart';

import '../../cart/models/cart_widget.dart';
import '../../kakao/main_view_model.dart';


class DefaultLayout extends StatefulWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final Widget? bottomNavigationBar;
  final MainViewModel mainViewModel;

  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    this.title,
    this.bottomNavigationBar,
    required this.mainViewModel,
    Key? key,
  }) : super(key: key);

  @override
  _DefaultLayoutState createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: widget.backgroundColor ?? Colors.white,
          appBar: widget.title != null ? CustomAppBar(
              title: widget.title!, mainViewModel: widget.mainViewModel) : null,
          body: widget.child,
          bottomNavigationBar: widget.bottomNavigationBar,
        );
  }
}