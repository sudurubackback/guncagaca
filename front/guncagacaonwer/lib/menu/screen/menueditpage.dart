import 'dart:convert';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guncagacaonwer/menu/models/menueditmodel.dart' as request;
import 'package:guncagacaonwer/menu/models/menuresponsemodel.dart' as response;
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';


class MenuEditPage extends StatefulWidget {
  final response.MenuEntity menuInfo; // 메뉴 정보

  MenuEditPage({required this.menuInfo});

  @override
  _MenuEditPageState createState() => _MenuEditPageState();
}

class _MenuEditPageState extends State<MenuEditPage> {

  TextEditingController menunameController = TextEditingController();
  TextEditingController menupriceController = TextEditingController();
  TextEditingController desController = TextEditingController();

  String selectedImage = ""; // 선택된 이미지의 파일 경로
  String selectedImageName = ""; // 선택된 이미지의 파일 이름
  request.Category? selectedCategory ; // 선택된 카테고리를 저장할 변수

  List<request.OptionsEntity> optionsList = []; // 옵션 목록을 저장할 리스트
  List<Widget> itemWidgets = [];

  void _addItem() {
    TextEditingController optionController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    setState(() {
      int index = itemWidgets.length;

      // 해당 항목의 데이터를 optionsList에 추가
      optionsList.add(request.OptionsEntity(
        id: '',
        optionName: '', // 초기값 설정
        detailsOptions: [request.DetailsOptionEntity(
          id: '',
          detailOptionName: '',
          additionalPrice: 0,
        )],
      ));

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
    });
  }

  html.File? file;

  Future<void> _pickImage() async {
    if (kIsWeb) {
      // 웹에서 실행되는 경우
      html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
      uploadInput.click();

      uploadInput.onChange.listen((e) {
        final files = uploadInput.files;
        if (files?.length == 1) {
          final uploadedFile = files![0];
          setState(() {
            file = uploadedFile; // html.File 객체를 저장
            selectedImageName = uploadedFile.name;
          });
        }
      });
    } else {
      // 모바일/데스크톱에서 실행되는 경우
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg'],
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
  }

  static final storage = FlutterSecureStorage();
  String? accessToken;
  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    selectedImage = widget.menuInfo.img;

    // 메뉴 정보를 가져와 각 필드를 초기화합니다.
    menunameController.text = widget.menuInfo.name; // 메뉴 이름
    menupriceController.text = widget.menuInfo.price.toString(); // 메뉴 가격
    desController.text = widget.menuInfo.description;
    selectedCategory = request.Category.values.firstWhere((e) => e.toString().split('.').last == widget.menuInfo.category);
    selectedImage = widget.menuInfo.img;

    // 옵션 목록을 초기화합니다.
    optionsList = widget.menuInfo.optionsEntity.map((option) {
      TextEditingController optionController = TextEditingController(text: option.optionName);
      TextEditingController priceController = TextEditingController(text: option.detailsOptions[0].additionalPrice.toString());
      return request.OptionsEntity(
        id: '', // ID 정보가 없으므로 초기값을 빈 문자열로 설정
        optionName: option.optionName,
        detailsOptions: [request.DetailsOptionEntity(
          id: '', // ID 정보가 없으므로 초기값을 빈 문자열로 설정
          detailOptionName: option.optionName,
          additionalPrice: option.detailsOptions[0].additionalPrice,
        )],
      );
    }).toList();

    // 옵션 위젯 목록을 초기화합니다.
    itemWidgets = optionsList.map((option) {
      int index = optionsList.indexOf(option);
      TextEditingController optionController = TextEditingController(text: option.optionName);
      TextEditingController priceController = TextEditingController(text: option.detailsOptions[0].additionalPrice.toString());

      return Row(
        children: [
          Expanded(
            child: Container(
              width: 150,
              child: TextField(
                controller: optionController,
                onChanged: (value) {
                  optionsList[index].optionName = value;
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
                  optionsList[index].detailsOptions[0].additionalPrice = int.parse(value);
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
                itemWidgets.removeAt(index);
                optionsList.removeAt(index);
              });
            },
          ),
        ],
      );
    }).toList();

    setupDio();
  }

  Future<void> setupDio() async {
    accessToken = await storage.read(key: 'accessToken');
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true, request: true));
    dio.options.headers['Authorization'] = 'Bearer $accessToken'; // 헤더에 토큰 추가
  }

  Future<void> updateMenu() async {
    var requestUrl = 'https://k9d102.p.ssafy.io/api/owner/menu/edit';

    String extension = selectedImageName.split('.').last;

    MultipartFile multipartFile;

    if (kIsWeb) {
      // 웹에서 실행되는 경우
      if (file != null) {
        final reader = html.FileReader();
        reader.readAsDataUrl(file!);
        await reader.onLoad.first;
        final encoded = reader.result as String;
        final stripped = encoded.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
        final content = base64.decode(stripped);
        multipartFile = MultipartFile.fromBytes(
          content,
          filename: selectedImageName,
          contentType: MediaType('image', extension),
        );
      } else {
        throw Exception('No image selected');
      }
    } else {
      // 모바일/데스크톱에서 실행되는 경우
      multipartFile = await MultipartFile.fromFile(
        selectedImage,
        filename: selectedImageName,
        contentType: MediaType('image', extension),  // 'Content-Type' 지정
      );
    }

    var formData = FormData.fromMap({
      'request': request.MenuEditRequest(
        id: widget.menuInfo.id,
        name: menunameController.text,
        price: int.parse(menupriceController.text),
        description: desController.text,
        img: "",
        category: selectedCategory!,
        optionsList: optionsList,
      ).toMap(),
      'file': multipartFile,
    });

    var response = await dio.put(
      requestUrl,
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update menu');
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardDeviceWidth = 500;
    final standardDeviceHeight = 350;

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
              height: 3 * (deviceHeight / standardDeviceHeight),
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
                    Image.network(
                      selectedImage, // 이미지 파일 경로
                      width: 90 * (deviceWidth / standardDeviceWidth),
                      height: 70 * (deviceHeight / standardDeviceHeight),
                    ), // 이미지 표시
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
                              child: DropdownButton<request.Category>(
                                isExpanded: true, // 이 속성을 true로 설정
                                value: selectedCategory,
                                items: request.Category.values.map((request.Category category) {
                                  return DropdownMenuItem<request.Category>(
                                    value: category,
                                    child: Text(category.toString().split('.').last), // Enum 값을 문자열로 변환
                                  );
                                }).toList(),
                                onChanged: (request.Category? newValue) {
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
                                bottom: 2 * (deviceHeight / standardDeviceHeight)),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1.0), // 외곽선 추가
                                borderRadius: BorderRadius.circular(5.0), // 모서리를 둥글게 만듭니다.
                              ),
                              width: 80 * (deviceWidth / standardDeviceWidth), // 원하는 너비 설정
                              height: 20 * (deviceHeight / standardDeviceHeight),
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
                                  bottom: 2 * (deviceHeight / standardDeviceHeight)),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1.0), // 외곽선 추가
                                borderRadius: BorderRadius.circular(5.0), // 모서리를 둥글게 만듭니다.
                              ),
                              width: 80 * (deviceWidth / standardDeviceWidth), // 원하는 너비 설정
                              height: 20 * (deviceHeight / standardDeviceHeight),
                              child: TextField(
                                controller: menupriceController,
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
            Container(
              margin: EdgeInsets.only(left: 50 * (deviceWidth / standardDeviceWidth)),
              height: 30 * (deviceHeight / standardDeviceHeight),
              child: Row(
                children: [
                  Text(
                    "메뉴 소개",
                    style: TextStyle(
                      fontSize: 10 * (deviceWidth / standardDeviceWidth),
                    ),
                  ),
                  SizedBox(width: 10 * (deviceWidth / standardDeviceWidth)),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: 2 * (deviceHeight / standardDeviceHeight)),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0), // 외곽선 추가
                      borderRadius: BorderRadius.circular(5.0), // 모서리를 둥글게 만듭니다.
                    ),
                    width: 300 * (deviceWidth / standardDeviceWidth), // 원하는 너비 설정
                    height: 30 * (deviceHeight / standardDeviceHeight),
                    child: TextField(
                      controller: desController, // 메뉴 소개를 위한 컨트롤러
                      decoration: InputDecoration(
                        border: InputBorder.none, // 내부 테두리 제거
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 300 * (deviceWidth / standardDeviceWidth),
              height: 110 * (deviceHeight / standardDeviceHeight),
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
                            _addItem; // + 버튼 클릭 시 항목 추가
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
                  onPressed: () async {
                    updateMenu();
                    Navigator.pop(context); // 이전 창으로 돌아가기
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
