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
              color: Color(0xff9B5748),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ListTile(
            contentPadding:
            EdgeInsets.symmetric(vertical: 13.0, horizontal: 16.0),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(
                        dummyPoints[index]['img'],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.03), // 오른쪽에 20만큼의 패딩
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          dummyPoints[index]['name'],
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                        Text(
                          dummyPoints[index]['point'].toString() + ' p',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
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
