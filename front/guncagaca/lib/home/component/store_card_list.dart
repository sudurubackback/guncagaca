import 'package:flutter/material.dart';
import 'package:guncagaca/home/component/store_card.dart';

import '../../kakao/main_view_model.dart';
import '../../store/models/store.dart';


class StoreCardList extends StatelessWidget {
  final List<Store> stores;
  final MainViewModel mainViewModel;
  final String? searchKeyword;

  StoreCardList({required this.stores, required this.mainViewModel,this.searchKeyword,});

  @override
  Widget build(BuildContext context) {

    List<Store> filteredStores = stores;

    // 만약 검색어가 있다면, 해당 검색어가 포함된 가게만 필터링합니다.
    if (searchKeyword != null && searchKeyword!.isNotEmpty) {
      filteredStores = stores.where((store) =>
          store.storeDetail.cafeName.toLowerCase().contains(searchKeyword!.toLowerCase())).toList();
    }

    return ListView.builder(
      itemCount: filteredStores.length,  // <-- stores.length 대신에 filteredStores.length를 사용합니다
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: StoreCard(
            store: filteredStores[index],  // <-- stores[index] 대신에 filteredStores[index]를 사용합니다
            mainViewModel: mainViewModel,
          ),
        );
      },
    );
  }
}
