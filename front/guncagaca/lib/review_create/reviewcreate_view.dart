import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../common/utils/dio_client.dart';
import '../common/utils/oauth_token_manager.dart';
import 'reviewcreate_component.dart';


class ReviewCreatePage extends StatefulWidget {
  final String cafeName;
  final int storeId;
  final String orderId;

  ReviewCreatePage({required this.cafeName, required this.storeId, required this.orderId});

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

    print(reviewResponse.data);
    if (reviewResponse.statusCode == 200) {
      print('리뷰 작성 성공 : ${reviewResponse.data}');
    } else {
      print('리뷰 작성 실패: ${reviewResponse.data}');
    }
  }

  @override
  Widget build(BuildContext context){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Color(0xfff8e9d7),
      statusBarIconBrightness: Brightness.dark,
    ));

    return GestureDetector (
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child :Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 20),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30.0,
                    color: Color(0xff000000),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only( top: 20.0),
                  child: const Row(
                    children: [
                      Text(
                        '리뷰 쓰기',
                        style: TextStyle(color: Colors.black, fontSize: 29.0),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 20),
                  child: Opacity(
                    opacity: 0.0,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Color(0xff000000),
                      onPressed: () {
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(2.0),
              child: Container(
                color: Color(0xff9B5748),
                height: 2.0,
              ),
            ),
          ),
        ),
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
                  color: Color(0xff9B5748),
                  width: 2.0,
                ),
                color: Color(0xff9B5748),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: InkWell(
                onTap: () async{
                  await _submitReview();
                  print("리뷰 작성 완료");
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
