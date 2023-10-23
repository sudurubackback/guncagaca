import 'package:flutter/material.dart';
import 'package:guncagaca/home/component/store_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: StoreCard(
              image: AssetImage('assets/image/cafe.PNG'),
              name: '커피비치 구미인동점',
              distance: '1.5Km',
              rating: 4.5,
              reviewCount: 14
          ),
        )
      ),
    );
  }
}
