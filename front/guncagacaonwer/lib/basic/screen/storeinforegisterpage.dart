import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:guncagacaonwer/basic/api/storeregister_api_service.dart';
import 'package:guncagacaonwer/basic/models/storeregistermodel.dart';
import 'package:guncagacaonwer/login/screen/loginpage.dart';
import 'package:image_picker/image_picker.dart';


class StoreInfoRegisterPage extends StatefulWidget {
  @override
  _StoreInfoRegisterPageState createState() => _StoreInfoRegisterPageState();
}

class _StoreInfoRegisterPageState extends State<StoreInfoRegisterPage> {
  String storeName = '';
  String address = '';
  String tel = '';
  MultipartFile? img;
  String description = '';

  final picker = ImagePicker();

  Future _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    // 이미지를 선택한 경우에만 할당
    if (pickedFile != null) {
      setState(() {
        img = MultipartFile.fromFileSync(pickedFile.path);
      });
    }
    // 나중에 사용할 때 null 체크를 수행
    if (img != null) {
      final storeRegisterRequest = StoreRegisterRequest(storeName, address, tel, img, description);
    }
  }

  late ApiService apiService;

  @override
  void initState() {
    super.initState();

    Dio dio = Dio();
    apiService = ApiService(dio);
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
                      Text(img as String), // 선택된 이미지 파일명 표시 또는 경로 표시
                    ],
                  ),
                ),
                SizedBox(height: 15 * (deviceHeight / standardDeviceHeight)),
                ElevatedButton(
                  onPressed: () async {
                    try {
                     // 요청 데이터 모델
                     final formData = StoreRegisterRequest(storeName, address, tel, img, description).toFormData();

                     // API 서비스 사용해 가게등록 요청
                     final reponse = await apiService.storeRegister(formData);

                     // 응답 처리
                     if (reponse.status == 0) {
                       // 가게 등록 성공 -> 로그인 창으로 이동
                       Navigator.of(context).pushReplacement(
                         MaterialPageRoute(
                           builder: (context) => LoginPage(),
                         ),
                       );
                     } else {
                       // 가게 등록 실패
                       showDialog(
                         context: context,
                         builder: (context) {
                           return AlertDialog(
                             title: Text("가게 등록 실패"),
                             content: Text("가게 등록에 실패했습니다. 다시 시도해 주세요."),
                             actions: <Widget> [
                               ElevatedButton(
                                 child: Text("확인"),
                                 onPressed: () {
                                   Navigator.of(context).pop();
                                   },
                                )
                              ],
                            );
                          }
                        );
                      }
                    } catch (e) {
                      // 통신 실패시 예외 처리
                      print("통신 실패 : $e");
                    }
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
