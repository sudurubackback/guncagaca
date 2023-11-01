import 'package:flutter/material.dart';
import 'package:guncagaca/common/const/colors.dart';
import 'package:guncagaca/common/layout/default_layout.dart';

import '../../store/view/store_detail_screen.dart';
import '../../store/models/store.dart';

class StoreCard extends StatelessWidget {
  final Store store;

  const StoreCard({
    required this.store,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap:  () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DefaultLayout(
                  title: store.cafeName,
                  child: StoreDetailScreen(storeId: store.storeId)),
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              //borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                store.img,
                width: 80,  // 원하는 이미지의 넓이로 조절하세요.
                height: 80, // 원하는 이미지의 높이로 조절하세요.
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(store.cafeName,
                  style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.w500,
                  ),),
                  SizedBox(height: 15.0),
                  Text('${store.distance} km'),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      _IconText(icon: Icons.star, label: store.starTotal.toString()),
                      SizedBox(width: 10.0),
                      _IconText(icon: Icons.receipt, label: '${store.reviewCount} 개')
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconText({required this.icon, required this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
          size: 14.0,
        ),
        const SizedBox(width: 5.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight:  FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
