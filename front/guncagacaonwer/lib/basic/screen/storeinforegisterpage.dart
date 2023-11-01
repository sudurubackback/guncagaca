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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9B5748),
        title: Text(
          "근카가카",
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
                  height: 30,
                ),
                Container(
                  width: 500,
                  height: 80,
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
                SizedBox(height: 10),
                Container(
                  width: 500,
                  height: 80,
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
                SizedBox(height: 10),
                Container(
                  width: 500,
                  height: 80,
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
                Container(
                  width: 520,
                  height: 80,
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
                SizedBox(height: 15),
                Container(
                  margin: EdgeInsets.only(right: 260),
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "사진첨부",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF9B5748),
                        ),
                      ),
                      SizedBox(width: 30),
                      ElevatedButton(
                        onPressed: _pickImage,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xFFE54816)),
                          minimumSize: MaterialStateProperty.all(Size(80, 30)),
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
                        width: 30,
                      ),
                      Text(img), // 선택된 이미지 파일명 표시 또는 경로 표시
                    ],
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // Handle registration logic here
                    // ...
                  },
                  style: ButtonStyle(
                    // 버튼의 최소 크기 설정
                    minimumSize: MaterialStateProperty.all(Size(400, 60)), // 가로 150, 세로 50

                    // 버튼의 배경 색상 설정
                    backgroundColor: MaterialStateProperty.all(Color(0xFF9B5748).withOpacity(0.5)), // 배경 색상
                  ),
                  child: Text(
                    '등록',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,// 텍스트 색상
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
