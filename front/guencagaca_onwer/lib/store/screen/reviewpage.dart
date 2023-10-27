import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  // 예시 리뷰 데이터. 실제 데이터로 교체해야 합니다.
  List<Map<String, dynamic>> reviewData = [
    {"star": 5, "content": "정말 좋은 제품입니다!"},
    {"star": 4, "content": "다만 가격이 조금 비쌉니다."},
    {"star": 5, "content": "완벽한 제품이에요!"},
    // 추가 리뷰 데이터
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: reviewData.length,
              itemBuilder: (context, index) {
                final review = reviewData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                  child: Container(
                    alignment: Alignment.center,
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 30.0), // 왼쪽 마진 설정
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center, // 왼쪽 정렬
                            children: [
                              RatingBar.builder(
                                initialRating: review["star"].toDouble(),
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                unratedColor: Colors.amber.withAlpha(400),
                                itemCount: 5,
                                itemSize: 30,
                                itemBuilder: (context, index) {
                                  if (index < review["star"].toDouble()) {
                                    return Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    );
                                  } else {
                                    return Icon(
                                      Icons.star_border,
                                      color: Colors.amber,
                                    );
                                  }
                                },
                                onRatingUpdate: (double value) {  },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 30.0), // 왼쪽 마진 설정
                          child: Text(
                            '리뷰 내용: ${review["content"]}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
