import 'package:flutter/material.dart';
import 'package:guncagaca/store/models/store_detail.dart';

import '../models/store.dart';

class IntroTabWidget extends StatelessWidget {
  final StoreDetail? storeDetail;

  const IntroTabWidget({super.key, required this.storeDetail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
        children: <Widget>[
          Text(
            '주소: ${storeDetail!.address}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            '영업 시간: ${storeDetail!.openTime} - ${storeDetail!.closeTime}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            storeDetail!.description,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

}
