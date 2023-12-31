import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:guncagaca/common/const/colors.dart';

import '../../kakao/main_view_model.dart';
import '../../store/view/store_detail_screen.dart';
import '../../store/models/store.dart';

class StoreCard extends StatelessWidget {
  final MainViewModel mainViewModel;
  final Store store;

  const StoreCard({
    required this.store,
    required this.mainViewModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => StoreDetailScreen(
          mainViewModel: mainViewModel,
          storeId: store.storeDetail.storeId,
        ));
      },
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  store.storeDetail.img,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              if (!store.storeDetail.isOpen)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.black45,
                    ),
                    child: Center(
                      child: Text(
                        "영업중이\n아닙니다",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  store.storeDetail.cafeName,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                    store.distance < 1
                        ? '${(store.distance * 1000).toInt()} m'
                        : '${store.distance.toStringAsFixed(2)} km'
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    _IconText(icon: Icons.star, label: store.storeDetail.starTotal.toStringAsFixed(2)),
                    SizedBox(width: 10.0),
                    _IconText(icon: Icons.receipt, label: '${store.storeDetail.reviewCount} 개')
                  ],
                ),
                SizedBox(height: 8.0),
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
