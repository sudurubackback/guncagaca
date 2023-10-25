import 'package:flutter/material.dart';
import 'package:guncagaca/home/component/store_card.dart';

import '../../store/models/store.dart';


class StoreCardList extends StatelessWidget {
  final List<Store> stores;

  StoreCardList({required this.stores});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stores.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: StoreCard(
            store: stores[index],  // 이 부분을 수정했습니다.
          ),
        );
      },
    );
  }
}
