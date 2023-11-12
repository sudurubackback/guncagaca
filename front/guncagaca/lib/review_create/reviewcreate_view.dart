import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:guncagaca/common/layout/custom_appbar.dart';
import '../common/const/colors.dart';
import '../common/utils/dio_client.dart';
import '../common/utils/oauth_token_manager.dart';
import '../kakao/main_view_model.dart';
import 'reviewcreate_component.dart';


class ReviewCreatePage extends StatefulWidget {
  final String cafeName;
  final int storeId;
  final String orderId;
  final MainViewModel mainViewModel;

  ReviewCreatePage({required this.cafeName, required this.storeId, required this.orderId, required this.mainViewModel});

  @override
  _ReviewCreateState createState() => _ReviewCreateState();
}

class _ReviewCreateState extends State<ReviewCreatePage> {
  double _rating = 5.0;
  final token = TokenManager().token;
  TextEditingController _textEditingController = TextEditingController();

  String baseUrl = dotenv.env['BASE_URL']!;
  Dio dio = DioClient.getInstance();

  // 리뷰 작성 api 호출
  Future<void> _submitReview() async {
    final reviewText = _textEditingController.text;
    final rating = _rating;

    final String apiUrl = '$baseUrl/api/store/${widget.storeId}/${widget.orderId}/review';
    var reviewResponse = await dio.post(
        apiUrl,
        data: {
          'comment': reviewText,
          'star': rating,
        },
        options: Options(
            headers: {
              'Authorization': "Bearer $token",
            }
        )
    );

    if (reviewResponse.statusCode == 200) {
      print('리뷰 작성 성공 : ${reviewResponse.data}');
    } else {
      print('리뷰 작성 실패: ${reviewResponse.data}');
    }
  }

  @override
  Widget build(BuildContext context){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: BACK_COLOR,
      statusBarIconBrightness: Brightness.dark,
    ));

    return GestureDetector (
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child :Scaffold(
        appBar: CustomAppBar(title: "리뷰 작성", mainViewModel: widget.mainViewModel,),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ReviewInputComponent(
                  rating: _rating,
                  cafeName: widget.cafeName,
                  onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
                textEditingController: _textEditingController,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.08,
              margin: const EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.only(left: 30.0, right: 50.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: PRIMARY_COLOR,
                  width: 2.0,
                ),
                color: PRIMARY_COLOR,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: InkWell(
                onTap: () async{
                  await _submitReview();
                  Navigator.pop(context, 'true');
                },
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '리뷰 작성',
                        style: TextStyle(fontSize: 20, color: Color(0xffffffff)),
                      ),
                    ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
