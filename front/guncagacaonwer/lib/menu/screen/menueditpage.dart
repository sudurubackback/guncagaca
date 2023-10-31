import 'package:flutter/material.dart';

class MenuEditPage extends StatefulWidget {
  final Map<String, dynamic> menuData; // 가상 데이터 모델

  MenuEditPage({required this.menuData});

  @override
  _MenuEditPageState createState() => _MenuEditPageState();
}

class _MenuEditPageState extends State<MenuEditPage> {

  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();


  String? selectedCategory; // 선택된 카테고리를 저장할 변수
  // 카테고리 목록
  List<String> categories = [
    '커피',
    '논-커피',
    '디저트',
    // 다른 카테고리 항목들
  ];
  List<List<String>> optionList = []; // 옵션 목록을 저장할 리스트
  List<Widget> itemWidgets = []; // 세부 옵션을 저장할 리스트

  void _addItem(String optionName, String optionPrice) {
    setState(() {
      final index = itemWidgets.length; // 현재 항목의 인덱스 저장

      itemWidgets.add(Row(
        children: [
          Expanded(
            child: Container(
              width: 150,
              child: TextField(
                controller: TextEditingController(text: optionName),
                decoration: InputDecoration(
                  hintText: '옵션 명',
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Container(
              width: 150,
              child: TextField(
                controller: TextEditingController(text: optionPrice),
                decoration: InputDecoration(
                  hintText: '가격',
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                itemWidgets.removeAt(index); // 해당 항목을 삭제
                optionList.removeAt(index); // 해당 항목의 데이터도 삭제
              });
            },
          ),
        ],
      ));
      optionList.add([optionName, optionPrice]);
    });
  }
  @override
  void initState() {
    super.initState();

    // widget의 menuData에서 메뉴명과 가격을 가져와 초기값으로 설정
    textController1.text = widget.menuData['text'];
    textController2.text = widget.menuData['price'];

    // 기존 옵션 데이터 가져와 초기값으로 설정
    if (widget.menuData['options'] != null) {
      for (var key in widget.menuData['options'].keys) {
        String optionName = key;
        String optionPrice = widget.menuData['options'][key];
        _addItem(optionName, optionPrice);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> menuData = widget.menuData;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9B5748),
        title: Text(
          "근카가카",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Text('대표사진'),
                        ElevatedButton(
                          onPressed: () {
                            // 이미지 변경 버튼을 눌렀을 때의 동작 추가
                          },
                          child: Text('이미지 변경'),
                        ),
                      ],
                    ),
                    Image.asset(menuData['image']), // 이미지 표시
                  ],
                ),
                SizedBox(
                  width: 50,
                ),
                Container(
                  width: 500,
                  height: 200,
                  color: Colors.green,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 150),
                        height: 40,
                        child: Row(
                          children: [
                            Text(
                              "카테고리",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(width: 50),
                            Container(
                              width: 200, // 원하는 너비 설정
                              child: DropdownButton(
                                isExpanded: true, // 이 속성을 true로 설정
                                value: selectedCategory,
                                items: categories.map((String category) {
                                  return DropdownMenuItem(
                                    value: category,
                                    child: Text(category),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedCategory = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 150),
                        height: 40,
                        child: Row(
                          children: [
                            Text(
                              "메뉴명",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(width: 66),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1.0), // 외곽선 추가
                                borderRadius: BorderRadius.circular(5.0), // 모서리를 둥글게 만듭니다.
                              ),
                              width: 200, // 가로 길이 설정
                              child: TextField(
                                controller: textController1,
                                decoration: InputDecoration(
                                  border: InputBorder.none, // 내부 테두리 제거
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 150),
                        height: 40,
                        child: Row(
                          children: [
                            Text(
                              "기본 가격",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(width: 43),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1.0), // 외곽선 추가
                                borderRadius: BorderRadius.circular(5.0), // 모서리를 둥글게 만듭니다.
                              ),
                              width: 200, // 가로 길이 설정
                              child: TextField(
                                controller: textController2,
                                decoration: InputDecoration(
                                  border: InputBorder.none, // 내부 테두리 제거
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(right: 100),
              width: 650,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "옵션",
                          style: TextStyle(
                            fontSize: 28,
                          ),
                        ),
                        SizedBox(
                          width: 500,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _addItem('옵션 명', '옵션 가격'); // + 버튼 클릭 시 항목 추가
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xFFCDABA4)),
                          ),
                          child: Text(
                            '+',
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ...itemWidgets, // 기존 항목 위젯 추가
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                // "취소" 버튼을 눌렀을 때의 동작 추가 (뒤로 가기)
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: Text(
                '취소',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // "확인" 버튼을 눌렀을 때의 동작 추가 (데이터 저장)
                // 여기에서 데이터를 수정하고 저장하는 로직을 구현합니다.
                // 저장이 완료되면 페이지를 닫을 수 있습니다.
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              child: Text(
                '확인',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
