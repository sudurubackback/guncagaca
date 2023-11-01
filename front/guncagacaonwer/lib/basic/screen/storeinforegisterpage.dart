import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class StoreInfoRegisterPage extends StatefulWidget {
  @override
  _StoreInfoRegisterPageState createState() => _StoreInfoRegisterPageState();
}

class _StoreInfoRegisterPageState extends State<StoreInfoRegisterPage> {
  String storeName = '';
  String address = '';
  String tel = '';
  String img = '';
  String description = '';

  final picker = ImagePicker();

  Future _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        img = pickedFile.path; // 이미지 경로를 상태 변수에 저장
      });
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
          "가게 등록",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: SingleChildScrollView( // Wrap the body with SingleChildScrollView
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10 * (deviceHeight / standardDeviceHeight),
                ),
                Container(
                  width: 250 * (deviceWidth / standardDeviceWidth),
                  height: 37 * (deviceHeight / standardDeviceHeight),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: '가게 명',
                      labelStyle: TextStyle(
                        color: Color(0xFF9B5748),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF9B5748)),
                      ),
                    ),
                    onChanged: (value) {
                      storeName = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 5 * (deviceHeight / standardDeviceHeight),
                ),
                Container(
                  width: 250 * (deviceWidth / standardDeviceWidth),
                  height: 37 * (deviceHeight / standardDeviceHeight),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: '가게 주소',
                      labelStyle: TextStyle(
                        color: Color(0xFF9B5748),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF9B5748)),
                      ),
                    ),
                    onChanged: (value) {
                      address = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 5 * (deviceHeight / standardDeviceHeight),
                ),
                Container(
                  width: 250 * (deviceWidth / standardDeviceWidth),
                  height: 37 * (deviceHeight / standardDeviceHeight),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: '가게 전화번호',
                      labelStyle: TextStyle(
                        color: Color(0xFF9B5748),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF9B5748)),
                      ),
                    ),
                    onChanged: (value) {
                      tel = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 5 * (deviceHeight / standardDeviceHeight),
                ),
                Container(
                  width: 255 * (deviceWidth / standardDeviceWidth),
                  height: 37 * (deviceHeight / standardDeviceHeight),
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        child: Text(
                          '가게 소개',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF9B5748),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5 * (deviceHeight / standardDeviceHeight),
                ),
                Container(
                  margin: EdgeInsets.only(right: 135 * (deviceWidth / standardDeviceWidth)),
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "사진첨부",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF9B5748),
                        ),
                      ),
                      SizedBox(width: 10 * (deviceWidth / standardDeviceWidth)),
                      ElevatedButton(
                        onPressed: _pickImage,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xFFE54816)),
                          minimumSize: MaterialStateProperty.all(Size(
                              40 * (deviceWidth / standardDeviceWidth),
                              15 * (deviceHeight / standardDeviceHeight))),
                        ),
                        child: Text(
                          "이미지 선택",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20 * (deviceWidth / standardDeviceWidth),
                      ),
                      Text(img), // 선택된 이미지 파일명 표시 또는 경로 표시
                    ],
                  ),
                ),
                SizedBox(height: 15 * (deviceHeight / standardDeviceHeight)),
                ElevatedButton(
                  onPressed: () {
                    // Handle registration logic here
                    // ...
                  },
                  style: ButtonStyle(
                    // 버튼의 최소 크기 설정
                    minimumSize: MaterialStateProperty.all(Size(
                        180 * (deviceWidth / standardDeviceWidth),
                        30 * (deviceHeight / standardDeviceHeight))), // 가로 150, 세로 50

                    // 버튼의 배경 색상 설정
                    backgroundColor: MaterialStateProperty.all(Color(0xFF9B5748).withOpacity(0.5)), // 배경 색상
                  ),
                  child: Text(
                    '등록',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15 * (deviceWidth / standardDeviceWidth),// 텍스트 색상
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
