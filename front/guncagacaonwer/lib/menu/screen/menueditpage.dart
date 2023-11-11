import 'package:flutter/material.dart';
import 'package:guncagacaonwer/menu/models/menuregistermodel.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';

class MenuEditPage extends StatefulWidget {
  final Map<String, dynamic> menuData; // 가상 데이터 모델

  MenuEditPage({required this.menuData});

  @override
  _MenuEditPageState createState() => _MenuEditPageState();
}

class _MenuEditPageState extends State<MenuEditPage> {

  TextEditingController menunameController = TextEditingController();
  TextEditingController textController2 = TextEditingController();

  String selectedImage = ""; // 선택된 이미지의 파일 경로
  String selectedImageName = ""; // 선택된 이미지의 파일 이름
  Category? selectedCategory ; // 선택된 카테고리를 저장할 변수

  List<OptionsEntity> optionsList = []; // 옵션 목록을 저장할 리스트
  List<Widget> itemWidgets = [];

  void _addItem() {
    TextEditingController optionController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    setState(() {
      int index = itemWidgets.length;
      itemWidgets.add(Row(
        children: [
          Expanded(
            child: Container(
              width: 150,
              child: TextField(
                controller: optionController,
                onChanged: (value) {
                  optionsList[index].optionName = value; // 사용자가 입력한 옵션 이름 저장
                },
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
                controller: priceController,
                onChanged: (value) {
                  optionsList[index].detailsOptions[0].additionalPrice = int.parse(value); // 사용자가 입력한 가격 저장
                },
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
                optionsList.removeAt(index); // 해당 항목의 데이터도 삭제
              });
            },
          ),
        ],
      ));
      // 해당 항목의 데이터를 optionsList에 추가
      optionsList.add(OptionsEntity(
        optionName: optionController.text, // 옵션 명
        detailsOptions: [DetailsOptionEntity(
          detailOptionName: optionController.text,
          additionalPrice: int.parse(priceController.text),
        )],
      ));
    });
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'], // 필요한 이미지 파일 확장자를 추가하세요.
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      setState(() {
        selectedImage = file.path!; // 선택한 이미지의 파일 경로를 저장
        selectedImageName = file.name;
      });
    } else {
      // 사용자가 취소를 누를 경우 처리
    }
  }

  Future<void> updateMenu() async {
    // 이 부분에서 필요한 정보를 모두 모아 `MenuEditRequest`를 생성합니다.
    // 이 예제에서는 'menunameController', 'textController2', 'selectedCategory' 및 'optionList'를 사용합니다.
    // 실제 앱에서는 사용자가 입력한 값을 사용해야 합니다.

    Map<String, dynamic> requestData = {
      'name': menunameController.text,
      'price': int.parse(textController2.text),
      'category': selectedCategory!,
      'optionsList': optionsList,
      // 필요한 다른 필드들
    };

    // FormData 인스턴스 생성
    FormData formData = new FormData.fromMap({
      ...requestData,
      if (selectedImage.isNotEmpty)
        "file": await MultipartFile.fromFile(selectedImage, filename: selectedImageName), // 업로드할 파일
    });

    Dio dio = Dio(); // Dio 인스턴스 생성

    try {
      Response response = await dio.put("/menu/edit", data: formData);

      if (response.statusCode == 200) {
        // 성공적으로 메뉴가 수정되었습니다.
        print("Menu updated successfully");
      } else {
        // 메뉴 수정에 실패했습니다.
        print("Failed to update the menu");
      }
    } catch (e) {
      print("An error occurred while updating the menu: $e");
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //
  //   // widget의 menuData에서 메뉴명과 가격을 가져와 초기값으로 설정
  //   menunameController.text = widget.menuData['text'];
  //   textController2.text = widget.menuData['price'];
  //
  //   // 기존 옵션 데이터 가져와 초기값으로 설정
  //   if (widget.menuData['options'] != null) {
  //     for (var key in widget.menuData['options'].keys) {
  //       String optionName = key;
  //       String optionPrice = widget.menuData['options'][key];
  //       _addItem(optionName, optionPrice);
  //     }
  //   }
  // }

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
                          onPressed: _pickImage,
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
                              child: DropdownButton<Category>(
                                isExpanded: true, // 이 속성을 true로 설정
                                value: selectedCategory,
                                items: Category.values.map((Category category) {
                                  return DropdownMenuItem<Category>(
                                    value: category,
                                    child: Text(category.toString().split('.').last), // Enum 값을 문자열로 변환
                                  );
                                }).toList(),
                                onChanged: (Category? newValue) {
                                  setState(() {
                                    selectedCategory = newValue; // newValue 값을 enum 형태로 저장
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
                                controller: menunameController,
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
                            // _addItem('옵션 명', '옵션 가격'); // + 버튼 클릭 시 항목 추가
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
