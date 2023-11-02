import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MenuRegistrationPage extends StatefulWidget {
  @override
  _MenuRegistrationPageState createState() => _MenuRegistrationPageState();
}

class _MenuRegistrationPageState extends State<MenuRegistrationPage> {
  // Define variables for text fields.
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();

  String selectedImage = ""; // 선택된 이미지의 파일 경로
  // 카테고리 저장
  String? selectedCategory; // 선택된 카테고리를 저장할 변수

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = pickedFile.path; // 선택한 이미지의 파일 경로를 저장
      });
    }
  }

  List<List<String>> optionList = []; // 옵션 목록을 저장할 리스트
  List<Widget> itemWidgets = []; // 세부 옵션을 저장할 리스트

  void _addItem() {
    setState(() {
      int index = itemWidgets.length;
      itemWidgets.add(Row(
        children: [
          Expanded(
            child: Container(
              width: 150,
              child: TextField(
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
      // 해당 항목의 데이터를 optionList에 추가
      optionList.add([
        textController1.text, // 옵션 명
        textController2.text, // 가격
      ]);
    });
  }

  // 카테고리 목록
  List<String> categories = [
    '커피',
    '논-커피',
    '디저트',
    // 다른 카테고리 항목들
  ];

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardDeviceWidth = 500;
    final standardDeviceHeight = 350;

    return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 60 * (deviceWidth / standardDeviceWidth)),
              height: 22 * (deviceHeight / standardDeviceHeight),
              child: Row(
                children: [
                  Text(
                    "메뉴명",
                    style: TextStyle(
                      fontSize: 10 * (deviceWidth / standardDeviceWidth),
                    ),
                  ),
                  SizedBox(width: 30 * (deviceWidth / standardDeviceWidth)),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0), // 외곽선 추가
                      borderRadius: BorderRadius.circular(5.0), // 모서리를 둥글게 만듭니다.
                    ),
                    width: 200 * (deviceWidth / standardDeviceWidth), // 가로 길이 설정
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
              height: 7 * (deviceHeight / standardDeviceHeight),
            ),
            Container(
              margin: EdgeInsets.only(left: 60 * (deviceWidth / standardDeviceWidth)),
              height: 22 * (deviceHeight / standardDeviceHeight),
              child: Row(
                children: [
                  Text(
                    "기본 가격",
                    style: TextStyle(
                      fontSize: 10 * (deviceWidth / standardDeviceWidth),
                    ),
                  ),
                  SizedBox(width: 19 * (deviceWidth / standardDeviceWidth)),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0), // 외곽선 추가
                      borderRadius: BorderRadius.circular(5.0), // 모서리를 둥글게 만듭니다.
                    ),
                    width: 200 * (deviceWidth / standardDeviceWidth), // 가로 길이 설정
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
            SizedBox(
              height: 7 * (deviceHeight / standardDeviceHeight),
            ),
            Container(
              margin: EdgeInsets.only(left: 60 * (deviceWidth / standardDeviceWidth)),
              height: 22 * (deviceHeight / standardDeviceHeight),
              child: Row(
                children: [
                  Text(
                    "카테고리",
                    style: TextStyle(
                      fontSize: 10 * (deviceWidth / standardDeviceWidth),
                    ),
                  ),
                  SizedBox(width: 22 * (deviceWidth / standardDeviceWidth)),
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
              height: 7 * (deviceHeight / standardDeviceHeight),
            ),
            Container(
              margin: EdgeInsets.only(left: 60 * (deviceWidth / standardDeviceWidth)),
              height: 22 * (deviceHeight / standardDeviceHeight),
              child: Row(
                children: [
                  Text(
                    "사진첨부",
                    style: TextStyle(
                      fontSize: 10 * (deviceWidth / standardDeviceWidth),
                    ),
                  ),
                  SizedBox(width: 22 * (deviceWidth / standardDeviceWidth)),
                  ElevatedButton(
                    onPressed: _pickImage,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFFE54816)), // 버튼 배경 색상 변경
                      minimumSize: MaterialStateProperty.all(Size(
                          50 * (deviceWidth / standardDeviceWidth),
                          20 * (deviceHeight / standardDeviceHeight))), // 버튼 최소 크기 설정
                    ),
                    child: Text(
                      "이미지 선택",
                      style: TextStyle(
                        color: Colors.white, // 텍스트 색상 변경
                        fontSize: 10 * (deviceWidth / standardDeviceWidth),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10 * (deviceWidth / standardDeviceWidth),
                  ),
                  // 선택된 이미지 파일명 표시
                  Text(selectedImage),
                ],
              ),
            ),
            SizedBox(
              height: 7 * (deviceHeight / standardDeviceHeight),
            ),
            Container(
              margin: EdgeInsets.only(right: 50 * (deviceWidth / standardDeviceWidth)),
              width: 267 * (deviceWidth / standardDeviceWidth),
              height: 90 * (deviceHeight / standardDeviceHeight),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0), // 외곽선 추가
              ),
              child: SingleChildScrollView( // SingleChildScrollView를 Container 안에 넣음
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 12 * (deviceWidth / standardDeviceWidth),
                        ),
                        Text(
                          "옵션",
                          style: TextStyle(
                            fontSize: 12 * (deviceWidth / standardDeviceWidth),
                          ),
                        ),
                        SizedBox(
                          width: 195 * (deviceWidth / standardDeviceWidth),
                        ),
                        ElevatedButton(
                          onPressed: _addItem, // + 버튼 클릭 시 항목 추가
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Color(0xFFCDABA4))
                          ),
                          child: Text(
                            '+',
                            style: TextStyle(
                              fontSize: 13 * (deviceWidth / standardDeviceWidth),
                              color: Colors.white,
                            ),),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7 * (deviceHeight / standardDeviceHeight),
                    ),
                    ...itemWidgets, // 기존 항목 위젯 추가
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 7 * (deviceHeight / standardDeviceHeight),
            ),
            Container(
              margin: EdgeInsets.only(right: 20 * (deviceWidth / standardDeviceWidth)),
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // 사용자로부터 메뉴 정보 가져오기
                  String menuName = textController1.text;
                  String menuPrice = textController2.text;
                  String menuCategory = textController3.text;

                  // 텍스트 필드 초기화
                  textController1.text = "";
                  textController2.text = "";
                  textController3.text = "";

                  // 옵션 목록 가져오기
                  List<String> options = optionList.map((optionData) {
                    return optionData.join(', '); // 옵션 명과 가격을 합친 문자열
                  }).toList();

                  // 항목 초기화
                  itemWidgets.clear();

                  // TODO: 메뉴 정보와 옵션 정보를 저장하는 로직을 구현
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFFCDABA4)), // 버튼 배경 색상 변경
                  minimumSize: MaterialStateProperty.all(Size(
                      70 * (deviceWidth / standardDeviceWidth),
                      25 * (deviceHeight / standardDeviceHeight))), // 버튼 최소 크기 설정
                ),
                child: Text(
                  "등록",
                  style: TextStyle(
                      fontSize: 12 * (deviceWidth / standardDeviceWidth),
                      color: Color(0xFF9B5748)// 버튼 텍스트 크기 변경
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
