import 'package:flutter/material.dart';
import 'dart:convert';

class JjimList extends StatefulWidget {
  @override
  _JjimListState createState() => _JjimListState();
}

class _JjimListState extends State<JjimList> {
  List<Map<String, dynamic>> dummyJjims = [];
  List<bool> toggleList = [];

  @override
  void initState() {
    super.initState();
    loadDummyJjims();
  }

  void loadDummyJjims() async {
    try {
      String jsonString = await DefaultAssetBundle.of(context)
          .loadString('assets/json/jjim_dumi.json');
      dummyJjims = List<Map<String, dynamic>>.from(json.decode(jsonString));
      toggleList = List.generate(dummyJjims.length, (index) => false);
      setState(() {});
    } catch (e) {
      print('Error decoding JSON: $e');
    }
  }

  void _toggleImage(int id) {
    int index = dummyJjims.indexWhere((item) => item['id'] == id);
    if (index != -1) {
      setState(() {
        toggleList[index] = !toggleList[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return dummyJjims.isEmpty
        ? Center(
      child: Text(
        "포인트함이 비었습니다.",
        style: TextStyle(fontSize: 18.0),
      ),
    )
        : ListView.builder(
      itemCount: dummyJjims.length,
      itemBuilder: (BuildContext context, int index) {
        int id = dummyJjims[index]['id'];
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 변경된 부분
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(
                        dummyJjims[index]['img'],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    dummyJjims[index]['name'],
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _toggleImage(id),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(toggleList[index]
                            ? 'assets/image/h2.png'
                            : 'assets/image/h1.png'),
                        fit: BoxFit.cover,
                      ),
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
