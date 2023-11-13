import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guncagacaonwer/menu/models/menueditmodel.dart' as request;
import 'package:guncagacaonwer/menu/models/menuresponsemodel.dart' as response;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:universal_html/html.dart' as html;


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

  request.Category? selectedCategory ; // 선택된 카테고리를 저장할 변수
  String selectedImage = ""; // 선택된 이미지의 파일 경로
  List<request.OptionsEntity> optionsList = [];
  List<Widget> itemWidgets = [];

  // 옵션 추가
  void _addItem() {
    setState(() {
      int index = itemWidgets.length;

      // 새로운 옵션을 optionsList에 추가
      optionsList.add(request.OptionsEntity(
        optionName: '',
        detailsOptions: [
          request.DetailsOptionEntity(
            detailOptionName: '',
            additionalPrice: 0,
          ),
        ],
      ));

      // 새로운 옵션을 itemWidgets에 추가
      itemWidgets.add(
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: 150,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: TextEditingController(text: optionsList[index].optionName),
                            onChanged: (value) {
                              optionsList[index].optionName = value;
                            },
                            decoration: InputDecoration(
                              hintText: '옵션 명',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            // 추가 버튼을 눌렀을 때 세부 옵션을 동적으로 추가
                            setState(() {
                              optionsList[index].detailsOptions.add(
                                request.DetailsOptionEntity(
                                  detailOptionName: '',
                                  additionalPrice: 0,
                                ),
                              );
                            });
                            _updateItemWidgets(); // 옵션 위젯을 업데이트
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            // 삭제 버튼을 눌렀을 때 해당 옵션을 제거
                            setState(() {
                              optionsList.removeAt(index);
                              _updateItemWidgets(); // 옵션 위젯을 업데이트
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // 세부 옵션을 반복문을 통해 추가
            for (int detailIndex = 0; detailIndex < optionsList[index].detailsOptions.length; detailIndex++)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 150,
                      child: TextField(
                        controller: TextEditingController(text: optionsList[index].detailsOptions[detailIndex].detailOptionName),
                        onChanged: (value) {
                          optionsList[index].detailsOptions[detailIndex].detailOptionName = value;
                        },
                        decoration: InputDecoration(
                          hintText: '세부 옵션 명',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      width: 150,
                      child: TextField(
                        controller: TextEditingController(text: optionsList[index].detailsOptions[detailIndex].additionalPrice.toString()),
                        onChanged: (value) {
                          optionsList[index].detailsOptions[detailIndex].additionalPrice = int.parse(value);
                        },
                        decoration: InputDecoration(
                          hintText: '세부 옵션 가격',
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      // 삭제 버튼을 눌렀을 때 해당 세부 옵션을 제거
                      setState(() {
                        optionsList[index].detailsOptions.removeAt(detailIndex);
                        _updateItemWidgets(); // 옵션 위젯을 업데이트
                      });
                    },
                  ),
                ],
              ),
            Divider(
              color: Colors.black, // 실선의 색상
              thickness: 1,         // 실선의 두께
            ),
          ],
        ),
      );
    });
  }

// 옵션 위젯을 업데이트하는 메서드
  void _updateItemWidgets() {
    itemWidgets = optionsList.map((option) {
      int index = optionsList.indexOf(option);
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  width: 150,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: TextEditingController(text: option.optionName),
                          onChanged: (value) {
                            optionsList[index].optionName = value;
                          },
                          decoration: InputDecoration(
                            hintText: '옵션 명',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          // 추가 버튼을 눌렀을 때 세부 옵션을 동적으로 추가
                          setState(() {
                            optionsList[index].detailsOptions.add(
                              request.DetailsOptionEntity(
                                detailOptionName: '',
                                additionalPrice: 0,
                              ),
                            );
                          });
                          _updateItemWidgets(); // 옵션 위젯을 업데이트
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          // 삭제 버튼을 눌렀을 때 해당 옵션을 제거
                          setState(() {
                            optionsList.removeAt(index);
                            _updateItemWidgets(); // 옵션 위젯을 업데이트
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // 세부 옵션을 반복문을 통해 추가
          for (int detailIndex = 0; detailIndex < optionsList[index].detailsOptions.length; detailIndex++)
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: 150,
                    child: TextField(
                      controller: TextEditingController(text: optionsList[index].detailsOptions[detailIndex].detailOptionName),
                      onChanged: (value) {
                        optionsList[index].detailsOptions[detailIndex].detailOptionName = value;
                      },
                      decoration: InputDecoration(
                        hintText: '세부 옵션 명',
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Container(
                    width: 150,
                    child: TextField(
                      controller: TextEditingController(text: optionsList[index].detailsOptions[detailIndex].additionalPrice.toString()),
                      onChanged: (value) {
                        optionsList[index].detailsOptions[detailIndex].additionalPrice = int.parse(value);
                      },
                      decoration: InputDecoration(
                        hintText: '세부 옵션 가격',
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    // 삭제 버튼을 눌렀을 때 해당 세부 옵션을 제거
                    setState(() {
                      optionsList[index].detailsOptions.removeAt(detailIndex);
                      _updateItemWidgets(); // 옵션 위젯을 업데이트
                    });
                  },
                ),
              ],
            ),
          Divider(
            color: Colors.black, // 실선의 색상
            thickness: 1,         // 실선의 두께
          ),
        ],
      );
    }).toList();
  }

  // 옵션 데이터 초기화 메서드
  void _initializeOptionData() {
    // 옵션 목록을 초기화합니다.
    optionsList = widget.menuInfo.optionsEntity.map((option) {
      return request.OptionsEntity(
        optionName: option.optionName,
        detailsOptions: option.detailsOptions.map((detailOption) {
          return request.DetailsOptionEntity(
            detailOptionName: detailOption.detailOptionName,
            additionalPrice: detailOption.additionalPrice,
          );
        }).toList(),
      );
    }).toList();

    // 옵션 위젯 목록을 초기화합니다.
    itemWidgets = optionsList.map((option) {
      int index = optionsList.indexOf(option);
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  width: 150,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: TextEditingController(text: option.optionName),
                          onChanged: (value) {
                            optionsList[index].optionName = value;
                          },
                          decoration: InputDecoration(
                            hintText: '옵션 명',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          // 추가 버튼을 눌렀을 때 세부 옵션을 동적으로 추가
                          setState(() {
                            optionsList[index].detailsOptions.add(
                              request.DetailsOptionEntity(
                                detailOptionName: '',
                                additionalPrice: 0,
                              ),
                            );
                          });
                          _updateItemWidgets(); // 옵션 위젯을 업데이트
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          // 삭제 버튼을 눌렀을 때 해당 옵션을 제거
                          setState(() {
                            optionsList.removeAt(index);
                            _updateItemWidgets(); // 옵션 위젯을 업데이트
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // 세부 옵션을 반복문을 통해 초기화합니다.
          for (var detailOption in option.detailsOptions)
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: 150,
                    child: TextField(
                      controller: TextEditingController(text: detailOption.detailOptionName),
                      onChanged: (value) {
                        detailOption.detailOptionName = value;
                      },
                      decoration: InputDecoration(
                        hintText: '세부 옵션 명',
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Container(
                    width: 150,
                    child: TextField(
                      controller: TextEditingController(text: detailOption.additionalPrice.toString()),
                      onChanged: (value) {
                        detailOption.additionalPrice = int.parse(value);
                      },
                      decoration: InputDecoration(
                        hintText: '세부 옵션 가격',
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    // 삭제 버튼을 눌렀을 때 해당 세부 옵션을 제거
                    setState(() {
                      option.detailsOptions.remove(detailOption);
                      _updateItemWidgets(); // 옵션 위젯을 업데이트
                    });
                  },
                ),
              ],
            ),
          Divider(
            color: Colors.black, // 실선의 색상
            thickness: 1,         // 실선의 두께
          ),
        ],
      );
    }).toList();
  }

  Uint8List? _imageBytes;
  String _imageFileName = '';

  void _loadImage() {
    final html.FileUploadInputElement input = html.FileUploadInputElement();
    input.accept = 'image/*';
    input.click();

    input.onChange.listen((html.Event e) {
      final html.File file = input.files!.first;
      final html.FileReader reader = html.FileReader();

      reader.onLoadEnd.listen((html.ProgressEvent e) {
        setState(() {
          _imageBytes = reader.result as Uint8List;

          // 파일명을 저장
          _imageFileName = file.name;

          // 선택한 이미지를 selectedImage로 대체
          selectedImage = _imageBytes != null ? _imageFileName : widget.menuInfo.img;

          // Uint8List를 base64 인코딩하여 String으로 변환
          String base64Image = base64Encode(_imageBytes as List<int>);

          // 이후에 base64Image를 사용하여 필요한 곳에 전달 또는 처리합니다.
        });
      });
      reader.readAsArrayBuffer(file);
    });
  }


  @override
  void initState() {
    super.initState();
    // 메뉴 정보를 이용하여 초기값 설정
    menunameController.text = widget.menuInfo.name;
    menupriceController.text = widget.menuInfo.price.toString();
    desController.text = widget.menuInfo.description;
    selectedCategory = request.convertStringToCategory(widget.menuInfo.category);
    selectedImage = widget.menuInfo.img;

    // 옵션 데이터 초기화
    _initializeOptionData();

    //Dio 설정
    setupDio();
  }

  static final storage = FlutterSecureStorage();
  String? accessToken;
  Dio dio = Dio();
  Future<void> setupDio() async {
    accessToken = await storage.read(key: 'accessToken');
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true, request: true));
    dio.options.headers['Authorization'] = 'Bearer $accessToken'; // 헤더에 토큰 추가
  }

  // 메뉴 수정을 위한 통신 코드
  Future<void> _updateMenu() async {
    try {
      var requestUrl = 'https://k9d102.p.ssafy.io/api/owner/menu/edit';

      // 메뉴 정보 생성
      var menuEditRequest = request.MenuEditRequest(
        id: widget.menuInfo.id,
        name: menunameController.text,
        price: int.parse(menupriceController.text),
        description: desController.text,
        img: "",
        category: selectedCategory!,
        optionsList: optionsList,
      );

      // JSON 데이터를 문자열로 변환
      String jsonData = jsonEncode(menuEditRequest.toJson());

      // FormData 생성
      FormData formData = FormData.fromMap({
        'file': MultipartFile.fromFile(
          _imageBytes! as String,
          filename: _imageFileName.isNotEmpty ? _imageFileName : 'menu_image.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
        'request': jsonData, // JSON 데이터 추가
      });

      // 요청 데이터 출력
      print('Request Data:');
      print(jsonData);

      // Dio로 PUT 요청
      var response = await dio.put(
        requestUrl,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',          },
        ),
      );
      print(response);

      if (response.statusCode != 200) {
        // 응답이 성공적이지 않으면 오류 처리
        print('Response Data (Error):');
        print(response.toString());
        throw Exception('Failed to update menu');
      } else {
        // 응답이 성공적이면 응답 데이터 출력
        print('Response Data:');
        print(response.toString());
      }
    } catch (error) {
      // 오류 처리
      print('Error updating menu: $error');
      // 예: 사용자에게 오류 메시지 표시
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
                          onPressed: _loadImage,
                          child: Text('이미지 변경'),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5 * (deviceWidth / standardDeviceWidth),
                    ),
                    _imageBytes != null
                      ? Image.memory(
                        _imageBytes!,
                        width: 90 * (deviceWidth / standardDeviceWidth),
                        height: 70 * (deviceHeight / standardDeviceHeight),
                      )
                      : Image.network(
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
                            _addItem(); // + 버튼 클릭 시 항목 추가
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
                    _updateMenu();
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
