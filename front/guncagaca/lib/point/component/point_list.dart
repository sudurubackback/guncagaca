import 'package:flutter/material.dart';
import 'dart:convert';

class PointList extends StatefulWidget {
  @override
  _PointListState createState() => _PointListState();
}

class _PointListState extends State<PointList> {
  List<Map<String, dynamic>> dummyPoints = [];

  @override
  void initState() {
    super.initState();
    loadDummyPoints();
  }

  void loadDummyPoints() async {
    try {
      String jsonString = await DefaultAssetBundle.of(context)
          .loadString('assets/json/point_dumi.json');
      dummyPoints = List<Map<String, dynamic>>.from(json.decode(jsonString));
      print("여기입니다");
      print(dummyPoints);
      setState(() {}); // 상태를 업데이트하여 위젯을 다시 그립니다.
    } catch (e) {
      print('Error decoding JSON: $e');
    }
  }

  void _removePoint(int index) {
    setState(() {
      dummyPoints.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return dummyPoints.isEmpty
        ? Center(
      child: Text(
        "포인트함이 비었습니다.",
        style: TextStyle(fontSize: 18.0),
      ),
    )
        : ListView.builder(
      itemCount: dummyPoints.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == dummyPoints.length) {
          return SizedBox(height: 20);
        }

        return Container(
          margin: EdgeInsets.only(top: 15, left: 10, right: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xff9B5748), // PRIMARY_COLOR를 적절한 색상으로 바꿔주세요.
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
                    Text(
                      dummyPoints[index]['name'] ,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      dummyPoints[index]['point'].toString()+ 'p',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                SizedBox(height: 6.0),
                Container(
                  width: 100, // 이미지의 너비
                  height: 100, // 이미지의 높이
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), // 모서리를 둥글게 만듦
                    image: DecorationImage(
                      image: NetworkImage(
                        dummyPoints[index]['img'], // 이미지 주소
                      ),
                      fit: BoxFit.cover, // 이미지를 박스에 맞춥니다.
                    ),
                  ),
                )
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
