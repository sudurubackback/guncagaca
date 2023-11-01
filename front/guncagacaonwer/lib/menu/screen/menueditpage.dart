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
            child:
              Container(
                width: 150 ,
                child: TextField(
                  controller: TextEditingController(text: optionName),
                  decoration: InputDecoration(
                    hintText: '옵션 명',
                  ),
                ),
              ),
          ),
          SizedBox(width: 10),
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
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardDeviceWidth = 500;
    final standardDeviceHeight = 350;

    Map<String, dynamic> menuData = widget.menuData;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9B5748),
        title: Text(
          "메뉴 수정",
          style: TextStyle(fontSize: 14 * (deviceWidth / standardDeviceWidth)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 16 * (deviceHeight / standardDeviceHeight),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Text('대표사진',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10 * (deviceWidth / standardDeviceWidth),
                          ),
                        ),
                        SizedBox(
                          height: 3 * (deviceHeight / standardDeviceHeight),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // 이미지 변경 버튼을 눌렀을 때의 동작 추가
                          },
                          child: Text('이미지 변경'),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5 * (deviceWidth / standardDeviceWidth),
                    ),
                    Image.asset(menuData['image']), // 이미지 표시
                  ],
                ),
                SizedBox(
                  width: 20 * (deviceWidth / standardDeviceWidth),
                ),
                Container(
                  width: 200 * (deviceWidth / standardDeviceWidth),
                  height: 90 * (deviceHeight / standardDeviceHeight),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 25 * (deviceWidth / standardDeviceWidth)),
                        height: 22 * (deviceHeight / standardDeviceHeight),
                        child: Row(
                          children: [
                            Text(
                              "카테고리",
                              style: TextStyle(
                                fontSize: 10 * (deviceWidth / standardDeviceWidth),
                              ),
                            ),
                            SizedBox(width: 20 * (deviceWidth / standardDeviceWidth)),
                            Container(
                              width: 80 * (deviceWidth / standardDeviceWidth), // 원하는 너비 설정
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
                        height: 4 * (deviceHeight / standardDeviceHeight),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25 * (deviceWidth / standardDeviceWidth)),
                        height: 22 * (deviceHeight / standardDeviceHeight),
                        child: Row(
                          children: [
                            Text(
                              "메뉴명",
                              style: TextStyle(
                                fontSize: 10 * (deviceWidth / standardDeviceWidth),
                              ),
                            ),
                            SizedBox(width: 28 * (deviceWidth / standardDeviceWidth)),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 4 * (deviceHeight / standardDeviceHeight),
                                  bottom: 3 * (deviceHeight / standardDeviceHeight)),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1.0), // 외곽선 추가
                                borderRadius: BorderRadius.circular(5.0), // 모서리를 둥글게 만듭니다.
                              ),
                              width: 80 * (deviceWidth / standardDeviceWidth), // 원하는 너비 설정
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
                        height: 4 * (deviceHeight / standardDeviceHeight),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25 * (deviceWidth / standardDeviceWidth)),
                        height: 22 * (deviceHeight / standardDeviceHeight),
                        child: Row(
                          children: [
                            Text(
                              "기본 가격",
                              style: TextStyle(
                                fontSize: 10 * (deviceWidth / standardDeviceWidth),
                              ),
                            ),
                            SizedBox(width: 16.5 * (deviceWidth / standardDeviceWidth)),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 4 * (deviceHeight / standardDeviceHeight),
                                  bottom: 3 * (deviceHeight / standardDeviceHeight)),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1.0), // 외곽선 추가
                                borderRadius: BorderRadius.circular(5.0), // 모서리를 둥글게 만듭니다.
                              ),
                              width: 80 * (deviceWidth / standardDeviceWidth), // 원하는 너비 설정
                              height: 20 * (deviceHeight / standardDeviceHeight),
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
              height: 10 * (deviceHeight / standardDeviceHeight),
            ),
            Container(
              width: 300 * (deviceWidth / standardDeviceWidth),
              height: 130 * (deviceHeight / standardDeviceHeight),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10 * (deviceWidth / standardDeviceWidth),
                        ),
                        Text(
                          "옵션",
                          style: TextStyle(
                            fontSize: 13 * (deviceWidth / standardDeviceWidth),
                          ),
                        ),
                        SizedBox(
                          width: 225 * (deviceWidth / standardDeviceWidth),
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
                              fontSize: 14 * (deviceWidth / standardDeviceWidth),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4 * (deviceHeight / standardDeviceHeight),
                    ),
                    ...itemWidgets, // 기존 항목 위젯 추가
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10 * (deviceHeight / standardDeviceHeight),
            ),
            Row(
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
          ],
        ),
      ),
    );
  }
}
