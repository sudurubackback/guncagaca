import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guncagacaonwer/common/const/colors.dart';
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
                      // color: Color(0xFFD9D9D9),
                      color: Colors.white,
                      border: Border.all(
                        color: PRIMARY_COLOR, // 외곽선 색상
                        width: 2.0, // 외곽선 두께
                      ),
                        borderRadius: BorderRadius.circular(20.0)
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
                            child: ReviewContent(content: review.content,nickname: review.nickname,),  // ReviewContent 위젯 사용
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
  final String nickname;

  ReviewContent({
    required this.content,
    required this.nickname,
  });

  @override
  _ReviewContentState createState() => _ReviewContentState();
}

class _ReviewContentState extends State<ReviewContent> {
  bool showFullText = false;
  final int previewLength = 30; // 미리보기에 나타낼 글자 수

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
        // 리뷰쓴 사람의 아이디 표시
        Text(
          '${widget.nickname} 님',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.025,),
        // 리뷰 내용 표시
        showFullText
            ? Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Text(
              widget.content,
              style: TextStyle(fontSize: 27),
            ),
          ),
        )
            : Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  _getPreviewText(),
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            if (widget.content.length > previewLength) // 예시로 30글자 이상일 때만 더 보기 버튼 표시
              TextButton(
                child: Text('더 보기', style: TextStyle(color: PRIMARY_COLOR)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('리뷰 내용', style: TextStyle(fontSize: 23)),
                        content: SingleChildScrollView(
                          child: Text(_getDialogText(), style: TextStyle(fontSize: 27)),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // 다이얼로그 닫기
                            },
                            child: Text('닫기', style: TextStyle(color: PRIMARY_COLOR)),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
          ],
        ),
      ],
    );
  }

  String _getPreviewText() {
    if (widget.content.length <= previewLength) {
      return widget.content;
    } else {
      return widget.content.substring(0, previewLength) + '...';
    }
  }

  String _getDialogText() {
    String dialogText = '';
    for (int i = 0; i < widget.content.length; i += previewLength) {
      int end = i + previewLength;
      if (end > widget.content.length) {
        end = widget.content.length;
      }
      dialogText += widget.content.substring(i, end) + '\n';
    }
    return dialogText.trim();
  }
}