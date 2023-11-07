import 'package:flutter/material.dart';
import 'package:guncagaca/home/component/store_card.dart';

import '../../kakao/main_view_model.dart';
import '../../store/models/store.dart';


class StoreCardList extends StatelessWidget {
  final List<Store> stores;
  final MainViewModel mainViewModel;

  StoreCardList({required this.stores, required this.mainViewModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stores.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: StoreCard(
            store: stores[index],
            mainViewModel: mainViewModel,
          ),
        );
      },
    );
  }
}
