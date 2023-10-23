import 'package:flutter/material.dart';
import 'package:guncagaca/common/const/colors.dart';

class StoreCard extends StatelessWidget {
  // 이미지
  final ImageProvider image;
  // 가게 이름
  final String name;
  // 거리
  final String distance;
  // 평점
  final double rating;
  // 리뷰 수
  final int reviewCount;

  const StoreCard({
    required this.image,
    // 가게 이름
    required this.name,
    // 거리
    required this.distance,
    // 평점
    required this.rating,
    // 리뷰 수
    required this.reviewCount,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          //borderRadius: BorderRadius.circular(15.0),
          child: Image(
            image: image,
            width: 100,  // 원하는 이미지의 넓이로 조절하세요.
            height: 100, // 원하는 이미지의 높이로 조절하세요.
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 13.0),
              Text(name,
              style: const TextStyle(
                fontSize: 20.0, fontWeight: FontWeight.w500,
              ),),
              SizedBox(height: 15.0),
              Text('$distance'),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  _IconText(icon: Icons.star, label: rating.toString()),
                  SizedBox(width: 10.0),
                  _IconText(icon: Icons.receipt, label: '$reviewCount 개')
                ],
              ),
            ],
          ),
        ),
      ],
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
