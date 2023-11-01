import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guncagaca/common/view/custom_appbar.dart';
import '../../kakao/main_view_model.dart';
import '../component/jjim_list.dart';


class JjimScreen extends StatelessWidget {
  final MainViewModel mainViewModel;

  const JjimScreen ({required this.mainViewModel});

  @override
  Widget build(BuildContext context) {


    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Color(0xfff8e9d7),
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
        child: CustomAppbar(title: '찜', imagePath: 'assets/image/jjim.png',)
      ),
      body: Column(
        children: [
          Expanded(
            child: JjimList(),
          ),
        ],
      ),
    );

  }
}



