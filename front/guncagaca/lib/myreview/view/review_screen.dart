import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guncagaca/common/view/custom_appbar.dart';
import '../../kakao/main_view_model.dart';
import '../component/review_list.dart';


class ReviewScreen extends StatelessWidget {

  final MainViewModel mainViewModel;

  const ReviewScreen ({required this.mainViewModel});

  @override
  Widget build(BuildContext context) {


    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Color(0xfff8e9d7),
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
        child: CustomAppbar(title: '나의 리뷰', imagePath: null,)
      ),
      body: Column(
        children: [
          Expanded(
            child: ReviewList(mainViewModel: mainViewModel,),
          ),
        ],
      ),
    );

  }
}



