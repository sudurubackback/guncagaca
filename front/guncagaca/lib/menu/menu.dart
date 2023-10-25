import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<DetailPage> {
  int basePrice = 3000; // 기본 가격

  int selectedShotIndex = 0; // 선택된 샷의 인덱스
  int selectedSizeIndex = 0; // 선택된 크기의 인덱스


  List<Map<String, dynamic>> shotOptions = [
    {"label": "1샷", "price": 0},
    {"label": "2샷", "price": 100},
    {"label": "3샷", "price": 200},

  ];

  List<Map<String, dynamic>> SizeOptions = [
    {"label": "500ml", "price": 0},
    {"label": "1L", "price": 500},


  ];

  @override
  void initState() {
    super.initState();

  }



  Widget buildSizeButton(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSizeIndex = index;

        });
      },
      child: Row(
        children: [
          Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Color(0xff9B5748),
                width: 2.0,
              ),
              color: index == selectedSizeIndex ? Color(0xff9B5748) : Colors.white,
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      SizeOptions[index]["label"],
                      style: TextStyle(
                        color: index == selectedSizeIndex ? Color(0xff9B5748) : Colors.black,
                        fontSize: 13.0,
                      ),
                    ),
                    Text(
                      '+ ${SizeOptions[index]["price"]}원',
                      style: TextStyle(
                        color: index == selectedSizeIndex ? Color(0xff9B5748) : Colors.black,
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildShotButton(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedShotIndex = index;
        });
      },
      child: Row(
        children: [
          Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Color(0xff9B5748),
                width: 2.0,
              ),
              color: index == selectedShotIndex ? Color(0xff9B5748) : Colors.white,
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      shotOptions[index]["label"],
                      style: TextStyle(
                        color: index == selectedShotIndex ? Color(0xff9B5748) : Colors.black,
                        fontSize: 13.0,
                      ),
                    ),
                    Text(
                      '+ ${shotOptions[index]["price"]}원',
                      style: TextStyle(
                        color: index == selectedShotIndex ? Color(0xff9B5748) : Colors.black,
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Color(0xfff8e9d7),
      statusBarIconBrightness: Brightness.dark,
    ));



    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.11),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          flexibleSpace: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Color(0xff000000),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          '근카가카 구미인동점',
                          style: TextStyle(color: Colors.black, fontSize: 19.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: IconButton(
                      icon: Icon(Icons.close),
                      iconSize: 30.0,
                      color: Color(0xff000000),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        'https://www.biz-con.co.kr/upload/images/202201/400_20220110114052876.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.2,
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xff9B5748),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '아메리카노',
                          ),
                          Text(
                              '3000원'
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          '맛으로 승부하는 깔끔한 리얼커피만의 고급진 맛',
                          style: TextStyle(fontSize: 15, color: Color(0xffD9A57F)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Container(
                  color: Color(0xffD9D9D9),
                  height: 2.0,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '사이즈',
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                      buildSizeButton(0),
                      SizedBox(height: 10.0),
                      buildSizeButton(1),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Container(
                  color: Color(0xffD9D9D9),
                  height: 2.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '샷 추가',
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                      buildShotButton(0), // 1샷 버튼
                      SizedBox(height: 10.0),
                      buildShotButton(1), // 2샷 버튼
                      SizedBox(height: 10.0),
                      buildShotButton(2), // 3샷 버튼
                    ],
                  ),
                ),

                Container(
                  color: Color(0xffD9D9D9),
                  height: 2.0,
                ),
                SizedBox(height: 200,)
              ],
            ),
          ),
          Align(
            alignment: Alignment(0, 0.9),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.08,
              margin: const EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffD9A57F),
                  width: 2.0,
                ),
                color: Color(0xffD9A57F),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: InkWell(
                onTap: () {
                  num total = basePrice + SizeOptions[selectedSizeIndex]["price"] + shotOptions[selectedShotIndex]["price"]; // 총 가격 계산
                  print("총 가격: $total 원");
                  Navigator.pop(context);
                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (basePrice + SizeOptions[selectedSizeIndex]["price"] + shotOptions[selectedShotIndex]["price"]).toString() + '원',
                        style: TextStyle(fontSize: 15, color: Color(0xffffffff)),
                      ),
                      Text(
                        '담기',
                        style: TextStyle(fontSize: 15, color: Color(0xffffffff)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
