import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guncagacaonwer/store/api/review_api_service.dart';
import 'package:guncagacaonwer/store/models/reviewmodel.dart';

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  List<ReviewResponse> reviewData = [];

  late ApiService apiService;
  static final storage = FlutterSecureStorage();

  Future<void> setupApiService() async {
    String? accessToken = await storage.read(key: 'accessToken');
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor(accessToken));
    dio.interceptors.add(LogInterceptor(responseBody: true));
    apiService = ApiService(dio);
  }

  @override
  void initState() {
    super.initState();

    setupApiService().then((_) {
      fetchReviews();
    });
  }

  void fetchReviews() async {
    try {
      final ownerResponse = await apiService.getOwnerInfo();

      final cafeId = ownerResponse.storeId;


      if (cafeId != null) {
        final response = await apiService.getReview(cafeId);
        if (response.isNotEmpty) {
          setState(() {
            reviewData = response;
          });
        } else {
          // 서버에서 리뷰를 가져오지 못했을 때의 처리
          print("리뷰를 가져오지 못했습니다.");
        }
      } else {
        // store_id가 없을 때의 처리
        print("store_id 값이 없습니다.");
      }
    } catch (e) {
      print("에러 : $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardDeviceWidth = 500;
    final standardDeviceHeight = 350;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 10 * (deviceHeight / standardDeviceHeight)),
          Expanded(
            child: ListView.builder(
              itemCount: reviewData.length,
              itemBuilder: (context, index) {
                final review = reviewData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 7),
                  child: Container(
                    alignment: Alignment.center,
                    width: 180 * (deviceWidth / standardDeviceWidth),
                    height: 55 * (deviceHeight / standardDeviceHeight),
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 14 * (deviceWidth / standardDeviceWidth)), // 왼쪽 마진 설정
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center, // 왼쪽 정렬
                            children: [
                              RatingBar.builder(
                                initialRating: review.star.toDouble(),
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                unratedColor: Colors.amber.withAlpha(400),
                                itemCount: 5,
                                itemSize: 12 * (deviceWidth / standardDeviceWidth),
                                itemBuilder: (context, index) {
                                  if (index < review.star.toDouble()) {
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
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 16 * (deviceWidth / standardDeviceWidth)), // 왼쪽 마진 설정
                            child: ReviewContent(content: '리뷰 내용: ${review.content}'),  // ReviewContent 위젯 사용
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

class ReviewContent extends StatefulWidget {
  final String content;

  ReviewContent({required this.content});

  @override
  _ReviewContentState createState() => _ReviewContentState();
}

class _ReviewContentState extends State<ReviewContent> {
  bool showFullText = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showFullText
          ? Container(
            child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Text(widget.content),
            ),
          )
          : Text(
            widget.content,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        TextButton(
          child: Text(showFullText ? '간략히 보기' : '더 보기'),
          onPressed: () {
            setState(() {
              showFullText = !showFullText;
            });
          },
        ),
      ],
    );
  }
}
