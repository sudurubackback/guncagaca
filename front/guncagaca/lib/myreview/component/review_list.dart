import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:guncagaca/common/const/colors.dart';

import '../../common/utils/dio_client.dart';
import '../../common/utils/oauth_token_manager.dart';
import '../../kakao/main_view_model.dart';
import '../../store/view/store_detail_screen.dart';
import '../my_review.dart';

class ReviewList extends StatefulWidget {
  final MainViewModel mainViewModel;
  ReviewList({required this.mainViewModel});

  @override
  _ReviewListState createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  final token = TokenManager().token;
  List<MyReview> myReviews = [];

  @override
  void initState() {
    super.initState();
    loadReviews();
  }

  String baseUrl = dotenv.env['BASE_URL']!;
  Dio dio = DioClient.getInstance();

  Future<void> loadReviews() async {
    final response = await dio.get(
      "$baseUrl/api/store/mypage/reviews",
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      setState(() {
        myReviews = data.map((item) => MyReview.fromMap(item)).toList();
      });
    } else {
      print('데이터 로드 실패, 상태 코드: ${response.statusCode}');
    }
  }

  void _goToStoreDetail(String cafeName, int id) {
    Get.to(() => StoreDetailScreen(storeId: id, mainViewModel: widget.mainViewModel,)
    );
  }


  @override
  Widget build(BuildContext context) {
    return myReviews.isEmpty
        ? Center(
      child: Text(
        "리뷰가 없습니다.",
        style: TextStyle(fontSize: 18.0),
      ),
    )
        : ListView.builder(
      itemCount: myReviews.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == myReviews.length) {
          return SizedBox(height: 20);
        }
        return Container(
          margin: EdgeInsets.only(top: 15, left: 10, right: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: PRIMARY_COLOR,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 16.0),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage(myReviews[index].img),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          myReviews[index].storeName,
                          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 25),
                        SizedBox(width: 10),
                        Text(myReviews[index].starTotal.toStringAsFixed(2),
                            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.chat, color: Colors.grey, size: 20),
                    SizedBox(width: 5),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: BACK_COLOR,
                          border: Border.all(color: PRIMARY_COLOR, width: 2.0),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(myReviews[index].comment,
                                  style: TextStyle(fontSize: 16.0)),
                            ),
                            Icon(Icons.star, color: Colors.amber, size: 18),
                            SizedBox(width: 3),
                            Text(myReviews[index].star.toString(),
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            onTap: () {
              _goToStoreDetail(myReviews[index].storeName, myReviews[index].storeId);
            },
          ),
        );
      },
    );
  }
}
