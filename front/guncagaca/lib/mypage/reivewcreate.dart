import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // RatingBar 패키지 추가

class ReviewCreatePage extends StatefulWidget {
  @override
  _ReviewCreateState createState() => _ReviewCreateState();
}

class _ReviewCreateState extends State<ReviewCreatePage> {
  double _rating = 3.0; // 초기 별점 설정

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Color(0xfff8e9d7),
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0, // 밑 줄 제거
          automaticallyImplyLeading: false, // leading 영역을 자동으로 생성하지 않도록 설정
          flexibleSpace: Center(
            child: Row(
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
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.18, top: 20.0),
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
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xff9B5748),
              height: 2.0,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Text(
                    "근카가카 구미인동점",
                    style: TextStyle(fontSize: 20, color: Color(0xff000000)),
                    textAlign: TextAlign.center,
                  ),
                  RatingBar.builder(
                    initialRating: _rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    unratedColor: Color(0xffD9D9D9),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.25,
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff9B5748),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TextField(
                textAlignVertical: TextAlignVertical.top,
                maxLines: null, // 여러 줄 입력 가능하도록 설정
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '리뷰를 작성해주세요',
                  hintStyle: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
                textInputAction: TextInputAction.newline, // 엔터 키를 눌렀을 때 줄바꿈
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
                onTap: () {
                  print("리뷰 작성 완료");
                  Navigator.pop(context);
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
    );
  }
}
