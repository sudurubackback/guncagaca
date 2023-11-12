// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:guncagacaonwer/menu/models/menuregistermodel.dart';
// import 'package:guncagacaonwer/menu/models/ownerinfomodel.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:path/path.dart' as path;
//
//
// class MenuRegistrationPage extends StatefulWidget {
//   @override
//   _MenuRegistrationPageState createState() => _MenuRegistrationPageState();
// }
//
// class _MenuRegistrationPageState extends State<MenuRegistrationPage> {
//   // Define variables for text fields.
//   TextEditingController menuNameController = TextEditingController(); // 메뉴 명
//   TextEditingController basePriceController = TextEditingController(); // 기본가격
//   TextEditingController desController = TextEditingController(); // 소개
//
//   String selectedImage = ""; // 선택된 이미지의 파일 경로
//   String selectedImageName = "";
//   // 카테고리 저장
//   Category? selectedCategory ; // 선택된 카테고리를 저장할 변수
//
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         selectedImage = pickedFile.path; // 선택한 이미지의 파일 경로를 저장
//         selectedImageName = path.basename(pickedFile.path);
//       });
//     }
//   }
//
//   List<OptionsEntity> optionsList = []; // 옵션 목록을 저장할 리스트
//   List<Widget> itemWidgets = [];
//
//   void _addItem() {
//     TextEditingController optionController = TextEditingController();
//     TextEditingController priceController = TextEditingController();
//
//     setState(() {
//       int index = itemWidgets.length;
//       itemWidgets.add(Row(
//         children: [
//           Expanded(
//             child: Container(
//               width: 150,
//               child: TextField(
//                 controller: optionController,
//                 onChanged: (value) {
//                   optionsList[index].optionName = value; // 사용자가 입력한 옵션 이름 저장
//                 },
//                 decoration: InputDecoration(
//                   hintText: '옵션 명',
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: 20),
//           Expanded(
//             child: Container(
//               width: 150,
//               child: TextField(
//                 controller: priceController,
//                 onChanged: (value) {
//                   optionsList[index].detailsOptions[0].additionalPrice = int.parse(value); // 사용자가 입력한 가격 저장
//                 },
//                 decoration: InputDecoration(
//                   hintText: '가격',
//                 ),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.clear),
//             onPressed: () {
//               setState(() {
//                 itemWidgets.removeAt(index); // 해당 항목을 삭제
//                 optionsList.removeAt(index); // 해당 항목의 데이터도 삭제
//               });
//             },
//           ),
//         ],
//       ));
//       // 해당 항목의 데이터를 optionsList에 추가
//       optionsList.add(OptionsEntity(
//         optionName: optionController.text, // 옵션 명
//         detailsOptions: [DetailsOptionEntity(
//           detailOptionName: optionController.text,
//           additionalPrice: int.parse(priceController.text),
//         )],
//       ));
//     });
//   }
//
//   // Define a Dio instance
//   Dio dio = Dio();
//
//   @override
//   void initState() {
//     super.initState();
//     initializeDio();
//   }
//
//   Future<void> initializeDio() async {
//     final storage = new FlutterSecureStorage();
//     String? accessToken = await storage.read(key: 'accessToken');
//
//     dio = new Dio();
//     dio.options.baseUrl = "https://k9d102.p.ssafy.io"; // 여기에는 실제 서버의 주소를 입력해주세요
//
//     // 액세스 토큰을 헤더에 추가
//     dio.options.headers["Authorization"] = "Bearer $accessToken";
//   }
//
//   Future<void> registerMenu() async {
//     if (selectedCategory == null) {
//       // 카테고리가 선택되지 않았을 경우 에러 메시지 출력
//       print("Please select a category");
//       return;
//     }
//
//     Dio dio = Dio(); // Dio 인스턴스 생성
//     Response response = await dio.get("/api/ceo/ownerInfo"); // GET 요청 수행
//     OwnerInfoResponse ownerInfo = OwnerInfoResponse.fromJson(response.data); // 응답 데이터를 OwnerInfoResponse 인스턴스로 변환
//     int storeId = ownerInfo.storeId;
//
//     // 사용자로부터 입력 받은 데이터를 MenuRegisterRequest 인스턴스로 변환
//     MenuRegisterRequest request = MenuRegisterRequest(
//       id: storeId, // 이 값은 실제로는 사용자가 선택한 카페의 ID로 설정해야 합니다.
//       name: menuNameController.text,
//       price: int.parse(basePriceController.text),
//       description: desController.text,
//       category: selectedCategory!,
//       optionsList: optionsList,
//       status: Status.ON_SALE,
//     );
//
//     // MenuRegisterRequest 인스턴스를 JSON 형태로 변환
//     Map<String, dynamic> requestData = request.toJson();
//
//     // FormData 인스턴스 생성
//     FormData formData = new FormData.fromMap({
//       ...requestData,
//       "img": await MultipartFile.fromFile(selectedImage, filename: path.basename(selectedImage)), // 업로드할 파일
//     });
//
//     try {
//       Response response = await dio.post("/api/ceo/menu/register", data: formData);
//
//       if (response.statusCode == 200) {
//         // 성공적으로 메뉴가 등록되었습니다.
//         print("Menu registered successfully");
//       } else {
//         // 메뉴 등록에 실패했습니다.
//         print("Failed to register the menu");
//       }
//     } catch (e) {
//       print("An error occurred while registering the menu: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final deviceWidth = MediaQuery.of(context).size.width;
//     final deviceHeight = MediaQuery.of(context).size.height;
//     final standardDeviceWidth = 500;
//     final standardDeviceHeight = 350;
//
//     return SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.only(left: 60 * (deviceWidth / standardDeviceWidth)),
//               height: 22 * (deviceHeight / standardDeviceHeight),
//               child: Row(
//                 children: [
//                   Text(
//                     "메뉴명",
//                     style: TextStyle(
//                       fontSize: 10 * (deviceWidth / standardDeviceWidth),
//                     ),
//                   ),
//                   SizedBox(width: 30 * (deviceWidth / standardDeviceWidth)),
//                   Container(
//                     margin: EdgeInsets.only(top: 10),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.black, width: 1.0), // 외곽선 추가
//                       borderRadius: BorderRadius.circular(5.0), // 모서리를 둥글게 만듭니다.
//                     ),
//                     width: 200 * (deviceWidth / standardDeviceWidth), // 가로 길이 설정
//                     child: TextField(
//                       controller: menuNameController,
//                       decoration: InputDecoration(
//                         border: InputBorder.none, // 내부 테두리 제거
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 7 * (deviceHeight / standardDeviceHeight),
//             ),
//             Container(
//               margin: EdgeInsets.only(left: 60 * (deviceWidth / standardDeviceWidth)),
//               height: 22 * (deviceHeight / standardDeviceHeight),
//               child: Row(
//                 children: [
//                   Text(
//                     "기본 가격",
//                     style: TextStyle(
//                       fontSize: 10 * (deviceWidth / standardDeviceWidth),
//                     ),
//                   ),
//                   SizedBox(width: 19 * (deviceWidth / standardDeviceWidth)),
//                   Container(
//                     margin: EdgeInsets.only(top: 10),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.black, width: 1.0), // 외곽선 추가
//                       borderRadius: BorderRadius.circular(5.0), // 모서리를 둥글게 만듭니다.
//                     ),
//                     width: 200 * (deviceWidth / standardDeviceWidth), // 가로 길이 설정
//                     child: TextField(
//                       controller: basePriceController,
//                       decoration: InputDecoration(
//                         border: InputBorder.none, // 내부 테두리 제거
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 7 * (deviceHeight / standardDeviceHeight),
//             ),
//             Container(
//               margin: EdgeInsets.only(left: 60 * (deviceWidth / standardDeviceWidth)),
//               height: 22 * (deviceHeight / standardDeviceHeight),
//               child: Row(
//                 children: [
//                   Text(
//                     "카테고리",
//                     style: TextStyle(
//                       fontSize: 10 * (deviceWidth / standardDeviceWidth),
//                     ),
//                   ),
//                   SizedBox(width: 22 * (deviceWidth / standardDeviceWidth)),
//                   Container(
//                     width: 80 * (deviceWidth / standardDeviceWidth), // 원하는 너비 설정
//                     child: DropdownButton<Category>(
//                       isExpanded: true, // 이 속성을 true로 설정
//                       value: selectedCategory,
//                       items: Category.values.map((Category category) {
//                         return DropdownMenuItem<Category>(
//                           value: category,
//                           child: Text(category.toString().split('.').last), // Enum 값을 문자열로 변환
//                         );
//                       }).toList(),
//                       onChanged: (Category? newValue) {
//                         setState(() {
//                           selectedCategory = newValue; // newValue 값을 enum 형태로 저장
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 7 * (deviceHeight / standardDeviceHeight),
//             ),
//             Container(
//               margin: EdgeInsets.only(left: 60 * (deviceWidth / standardDeviceWidth)),
//               height: 22 * (deviceHeight / standardDeviceHeight),
//               child: Row(
//                 children: [
//                   Text(
//                     "사진첨부",
//                     style: TextStyle(
//                       fontSize: 10 * (deviceWidth / standardDeviceWidth),
//                     ),
//                   ),
//                   SizedBox(width: 22 * (deviceWidth / standardDeviceWidth)),
//                   ElevatedButton(
//                     onPressed: _pickImage,
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(Color(0xFFE54816)), // 버튼 배경 색상 변경
//                       minimumSize: MaterialStateProperty.all(Size(
//                           50 * (deviceWidth / standardDeviceWidth),
//                           20 * (deviceHeight / standardDeviceHeight))), // 버튼 최소 크기 설정
//                     ),
//                     child: Text(
//                       "이미지 선택",
//                       style: TextStyle(
//                         color: Colors.white, // 텍스트 색상 변경
//                         fontSize: 10 * (deviceWidth / standardDeviceWidth),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10 * (deviceWidth / standardDeviceWidth),
//                   ),
//                   // 선택된 이미지 파일명 표시
//                   Text(selectedImage),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 7 * (deviceHeight / standardDeviceHeight),
//             ),
//             Container(
//               margin: EdgeInsets.only(right: 50 * (deviceWidth / standardDeviceWidth)),
//               width: 267 * (deviceWidth / standardDeviceWidth),
//               height: 90 * (deviceHeight / standardDeviceHeight),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.black, width: 1.0), // 외곽선 추가
//               ),
//               child: SingleChildScrollView( // SingleChildScrollView를 Container 안에 넣음
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         SizedBox(
//                           width: 12 * (deviceWidth / standardDeviceWidth),
//                         ),
//                         Text(
//                           "옵션",
//                           style: TextStyle(
//                             fontSize: 12 * (deviceWidth / standardDeviceWidth),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 195 * (deviceWidth / standardDeviceWidth),
//                         ),
//                         ElevatedButton(
//                           onPressed: _addItem, // + 버튼 클릭 시 항목 추가
//                           style: ButtonStyle(
//                               backgroundColor: MaterialStateProperty.all(Color(0xFFCDABA4))
//                           ),
//                           child: Text(
//                             '+',
//                             style: TextStyle(
//                               fontSize: 13 * (deviceWidth / standardDeviceWidth),
//                               color: Colors.white,
//                             ),),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 7 * (deviceHeight / standardDeviceHeight),
//                     ),
//                     ...itemWidgets, // 기존 항목 위젯 추가
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 7 * (deviceHeight / standardDeviceHeight),
//             ),
//             Container(
//               margin: EdgeInsets.only(right: 20 * (deviceWidth / standardDeviceWidth)),
//               alignment: Alignment.centerRight,
//               child: ElevatedButton(
//                 onPressed: registerMenu,
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Color(0xFFCDABA4)), // 버튼 배경 색상 변경
//                   minimumSize: MaterialStateProperty.all(Size(
//                       70 * (deviceWidth / standardDeviceWidth),
//                       25 * (deviceHeight / standardDeviceHeight))), // 버튼 최소 크기 설정
//                 ),
//                 child: Text(
//                   "등록",
//                   style: TextStyle(
//                       fontSize: 12 * (deviceWidth / standardDeviceWidth),
//                       color: Color(0xFF9B5748)// 버튼 텍스트 크기 변경
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         )
//     );
//   }
// }
