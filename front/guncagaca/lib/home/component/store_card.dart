import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:guncagaca/common/const/colors.dart';
import 'package:guncagaca/common/layout/default_layout.dart';

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
        if (!store.isOpen) { // 영업중이 아니라면 다이얼로그 표시
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Column(
                children: [
                  Text('알림'),
                  Divider(color: Colors.grey),  // 구분선 추가
                ],
              ),
              content: Text('영업중이 아닙니다.\n영업시간에 다시 방문해주세요.'),
              actions: [
                TextButton(
                  child: Text('확인',
                  style: TextStyle(color: PRIMARY_COLOR),),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        } else { // 영업중이라면 상세 화면으로 이동
          Get.to(() =>
              DefaultLayout(
                title: store.cafeName,
                mainViewModel: mainViewModel,
                child: StoreDetailScreen(storeId: store.storeId, mainViewModel: mainViewModel),
              )
          );
        }
      },
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  store.img,
                  width: 80,  // 원하는 이미지의 넓이로 조절하세요.
                  height: 80, // 원하는 이미지의 높이로 조절하세요.
                  fit: BoxFit.cover,
                ),
              ),
              if (!store.isOpen)
                Positioned.fill(
                  child: Container(
                    color: Colors.black45,
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
                  store.cafeName,
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
