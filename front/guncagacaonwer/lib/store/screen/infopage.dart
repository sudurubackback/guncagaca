import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StoreInfoPage extends StatefulWidget {
  @override
  _StoreInfoPageState createState() => _StoreInfoPageState();
}

class _StoreInfoPageState extends State<StoreInfoPage> {
  TimeOfDay? openingTime;
  TimeOfDay? closingTime;
  String tel = '';
  MultipartFile? img;
  String description = '';


  TextEditingController openingTimeController = TextEditingController();
  TextEditingController closingTimeController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController desController = TextEditingController();

  Future<void> _selectTime(BuildContext context, TextEditingController controller, TimeOfDay? selectedTime, bool isOpeningTime) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (newTime != null) {
      setState(() {
        if (isOpeningTime) {
          openingTime = newTime; // 영업 시작 시간 업데이트
          controller.text = newTime.format(context);
        } else {
          closingTime = newTime; // 영업 종료 시간 업데이트
          controller.text = newTime.format(context);
        }
      });
    }
  }

  final picker = ImagePicker();

  Future _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    // 이미지를 선택한 경우에만 할당
    if (pickedFile != null) {
      setState(() {
        img = MultipartFile.fromFileSync(pickedFile.path);
      });
    }
  }

  bool isButtonEnabled = true;

  void updateInfo() async {
    Dio dio = Dio();

    FormData formData = FormData.fromMap({
      "file" : img,
      "tel" : telController.text,
      "description" : desController.text,
      "openTime" : openingTimeController.text,
      "closeTime" : closingTimeController.text,
    });

    var response = await dio.put(
      "http://k9d102.p.ssafy.io/api/store/",
      data: formData,
      options: Options(
        headers: {
          "Authorization" : "token",
        }
      )
    );
    // 응답 출력
    print(response.data);

    // 응답 처리
    if (response.statusCode == 200) {
      var responseBody = response.data;
      print('Status: ${responseBody['status']}, Message: ${responseBody['message']}');
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardDeviceWidth = 500;
    final standardDeviceHeight = 350;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10 * (deviceHeight / standardDeviceHeight),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 50 * (deviceWidth / standardDeviceWidth),
                ),
                child: Container(
                  height: 30 * (deviceHeight / standardDeviceHeight), // 원하는 높이로 조절하세요
                  child: Row(
                    children: [
                      Text(
                        "가게 전화번호",
                        style: TextStyle(
                          fontSize: 9 * (deviceWidth / standardDeviceWidth),
                        ),
                      ),
                      SizedBox(width: 10 * (deviceWidth / standardDeviceWidth)),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        width: 200 * (deviceWidth / standardDeviceWidth),
                        child: TextField(
                          controller: telController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10 * (deviceHeight / standardDeviceHeight)),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 50 * (deviceWidth / standardDeviceWidth),
                    ),
                    child: Text(
                      "가게 소개",
                      style: TextStyle(
                        fontSize: 9 * (deviceWidth / standardDeviceWidth),
                      ),
                    ),
                  ),
                  SizedBox(width: 26 * (deviceWidth / standardDeviceWidth)),
                  Container(
                    width: 200 * (deviceWidth / standardDeviceWidth),
                    height: 40 * (deviceHeight / standardDeviceHeight),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: SingleChildScrollView(
                        child: TextFormField(
                          controller: desController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10 * (deviceHeight / standardDeviceHeight)),
              Padding(
                padding: EdgeInsets.only(left: 50 * (deviceWidth / standardDeviceWidth)),
                child: Row(
                  children: [
                    Text(
                      "영업 시간 : ",
                      style: TextStyle(
                        fontSize: 9 * (deviceWidth / standardDeviceWidth),
                      ),
                    ),
                    SizedBox(width: 20 * (deviceWidth / standardDeviceWidth)),
                    GestureDetector(
                      onTap: () {
                        _selectTime(context, openingTimeController, openingTime, true);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9),
                        ),
                        width: 40 * (deviceWidth / standardDeviceWidth),
                        child: Center(
                          child: TextFormField(
                            enabled: false,
                            controller: openingTimeController,
                            decoration: InputDecoration(
                              hintText: openingTime != null ? openingTime!.format(context) : '선택',
                            ),
                            style: TextStyle(
                              color: Colors.black, // 텍스트 색상 설정
                              fontSize: 9 * (deviceWidth / standardDeviceWidth), // 텍스트 크기 설정
                              // 다른 텍스트 스타일 속성도 지정 가능
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 7 * (deviceWidth / standardDeviceWidth)),
                    Text(
                      "~",
                      style: TextStyle(
                        fontSize: 9 * (deviceWidth / standardDeviceWidth),
                      ),
                    ),
                    SizedBox(width: 7 * (deviceWidth / standardDeviceWidth)),
                    GestureDetector(
                      onTap: () {
                        _selectTime(context, closingTimeController, closingTime, false);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9),
                        ),
                        width: 40 * (deviceWidth / standardDeviceWidth),
                        child: Center(
                          child: TextFormField(
                            enabled: false,
                            controller: closingTimeController,
                            decoration: InputDecoration(
                              hintText: closingTime != null ? closingTime!.format(context) : '선택',
                            ),
                            style: TextStyle(
                              color: Colors.black, // 텍스트 색상 설정
                              fontSize: 9 * (deviceWidth / standardDeviceWidth), // 텍스트 크기 설정
                              // 다른 텍스트 스타일 속성도 지정 가능
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 7 * (deviceHeight / standardDeviceHeight)),
              Padding(
                padding: EdgeInsets.only(left: 50 * (deviceWidth / standardDeviceWidth)),
                child: Row(
                  children: [
                    Text(
                      "사진첨부",
                      style: TextStyle(
                        fontSize: 9 * (deviceWidth / standardDeviceWidth),
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 29 * (deviceWidth / standardDeviceWidth)),
                    ElevatedButton(
                      onPressed: _pickImage,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFFE54816)),
                        minimumSize: MaterialStateProperty.all(Size(
                            40 * (deviceWidth / standardDeviceWidth),
                            20 * (deviceHeight / standardDeviceHeight))),
                      ),
                      child: Text(
                        "이미지 선택",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8 * (deviceWidth / standardDeviceWidth),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20 * (deviceWidth / standardDeviceWidth),
                    ),
                    // Text(img as String), // 선택된 이미지 파일명 표시 또는 경로 표시
                  ],
                ),
              ),
              SizedBox(height: 15 * (deviceHeight / standardDeviceHeight)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isButtonEnabled = !isButtonEnabled;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: isButtonEnabled ? Color(0xFFFF5E5E) : Colors.grey,
                      minimumSize: Size(140, 60),
                    ),
                    child: Text(
                      "영업 중",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(140, 60),
                      primary: Color(0xFF038527),
                    ),
                    child: Text(
                      "수정",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
