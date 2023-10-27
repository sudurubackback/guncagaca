import 'package:flutter/material.dart';
import 'dart:convert';

class ReviewList extends StatefulWidget {
  @override
  _ReviewListState createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  List<Map<String, dynamic>> dummyReviews = [];

  @override
  void initState() {
    super.initState();
    loadDummyReviews();
  }

  void loadDummyReviews() async {
    try {
      String jsonString = await DefaultAssetBundle.of(context)
          .loadString('assets/json/review_dumi.json');
      dummyReviews = List<Map<String, dynamic>>.from(json.decode(jsonString));
      print("여기입니다");
      print(dummyReviews);
      setState(() {}); // 상태를 업데이트하여 위젯을 다시 그립니다.
    } catch (e) {
      print('Error decoding JSON: $e');
    }
  }

  void _removeReview(int index) {
    setState(() {
      dummyReviews.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return dummyReviews.isEmpty
        ? Center(
      child: Text(
        "리뷰가 없습니다.",
        style: TextStyle(fontSize: 18.0),
      ),
    )
    : ListView.builder(
      itemCount: dummyReviews.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == dummyReviews.length) {
          return SizedBox(height: 20);
        }

        return Container(
          margin: EdgeInsets.only(top: 15, left: 10, right: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xff9B5748),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ListTile(
            contentPadding:
            EdgeInsets.symmetric(vertical: 13.0, horizontal: 16.0),
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
                              image: NetworkImage(
                                dummyReviews[index]['img'],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          dummyReviews[index]['name'],
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 25),
                        SizedBox(width: 10,),
                        Text(
                          dummyReviews[index]['star'].toString(),
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color(0xffF8E9D7),
                    border: Border.all(
                      color: Color(0xff9B5748),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    dummyReviews[index]['comment'],
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
            onTap: () {
              // 알림을 눌렀을 때의 동작을 추가하세요.
            },
          ),
        );
      },
    );
  }
}
