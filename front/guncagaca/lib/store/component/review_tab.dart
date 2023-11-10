import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../common/utils/dio_client.dart';
import '../../common/utils/oauth_token_manager.dart';
import '../models/review.dart';

class ReviewTabWidget extends StatefulWidget {
  final int cafeId;

  ReviewTabWidget({required this.cafeId});

  @override
  _ReviewTabWidgetState createState() => _ReviewTabWidgetState();
}

class _ReviewTabWidgetState extends State<ReviewTabWidget> {
  List<Review> reviews = [];
  final token = TokenManager().token;

  @override
  void initState() {
    super.initState();
    fetchReviewList().then((result) {
      setState(() {
        reviews = result;
      });
    });
  }

  String baseUrl = dotenv.env['BASE_URL']!;
  Dio dio = DioClient.getInstance();

  Future<List<Review>> fetchReviewList() async {
    final String apiUrl = "$baseUrl/api/store/${widget.cafeId}/review";

    final response = await dio.get(
        apiUrl,
        options: Options(
            headers: {
              'Authorization': "Bearer $token",
            }
        )
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonData = response.data;
      return jsonData.map((json) => Review.fromMap(json)).toList();
    } else {
      throw Exception("Failed to fetch menus.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            title: Text(reviews[index].content),
            subtitle: Text(reviews[index].nickname),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.yellow),
                Text(reviews[index].star.toString()),
              ],
            ),
          ),
        );
      },
    );
  }
}
