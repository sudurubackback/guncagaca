import 'package:flutter/material.dart';
import 'package:guncagacaonwer/menu/screen/menueditpage.dart';

class MenuAllPage extends StatefulWidget {
  @override
  _MenuAllPageState createState() => _MenuAllPageState();
}

class _MenuAllPageState extends State<MenuAllPage> {
  int selectedButtonIndex = 0;

  List<Map<String, dynamic>> menulists = [
    {
      'text': '아메리카노',
      'image': 'assets/americano.jpg',
      'category': '커피',
      'options': {
        '샷추가': '500',
        '얼음추가': '0',
        '시럽추가': '0',
      },
      'price': '4,500원',
    },
    {
      'text': '카페라떼',
      'image': 'assets/cafelatte.jpg',
      'category': '커피',
      'options': {
        '샷추가': '500',
        '시럽추가': '0',
      },
      'price': '5,000원',
    },
    {
      'text': '초코칩 프라푸치노',
      'image': 'assets/chocochipfrappuccino.jpg',
      'category': '논커피',
      'options': {
        '얼음추가': '0',
        '휘핑크림추가': '500',
      },
      'price': '6,000원',
    },
  ];

  // void _editMenuItem(Map<String, dynamic> menuItem) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (BuildContext context) {
  //         return EditMenuItemPage(initialData: menuItem);
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final standardDeviceWidth = 500;
    final standardDeviceHeight = 350;
    
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 4개씩 표시
      ),
      itemCount: menulists.length, // 텍스트 목록의 길이에 따라 박스 수 조정
      itemBuilder: (BuildContext context, int index) {
        Map<String, dynamic> menu = menulists[index]; // 해당 인덱스의 박스 정보 가져오기
        String menuText = menu['text'];
        String imagePath = menu['image'];

        return Container(
          margin: EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
          decoration: BoxDecoration(
            color: Colors.white, // 각 박스의 배경색
            border: Border.all(
              color: Colors.black, // 외각선 색상
              width: 1.0, // 외각선 두께
            ),
          ),
          width: 80 * (deviceWidth / standardDeviceWidth), // 각 박스의 너비
          height: 80 * (deviceHeight / standardDeviceHeight), // 각 박스의 높이
          child: Column(
            children: [
              // 이미지
              Image.asset(
                imagePath, // 이미지 파일 경로
                width: 90 * (deviceWidth / standardDeviceWidth),
                height: 80 * (deviceHeight / standardDeviceHeight),
                fit: BoxFit.cover,
              ),
              // 텍스트 중앙에 위치
              SizedBox(
                height: 3 * (deviceHeight / standardDeviceHeight),
              ),
              Text(
                menuText, // 박스에 할당된 텍스트 출력
                textAlign: TextAlign.center, // 텍스트 중앙 정렬
              ),
              SizedBox(
                height: 2 * (deviceHeight / standardDeviceHeight),
              ),
              // 버튼들을 나란히 배치하는 Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 버튼들을 가로로 공간을 균등하게 분배하도록 설정
                children: [
                  // 첫 번째 버튼
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MenuEditPage(menuData: menu); // MenuEditPage는 메뉴 수정 페이지의 위젯입니다.
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF038527),
                    ),
                    child: Text('수정'),
                  ),
                  // 두 번째 버튼
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('삭제 확인'),
                            content: Text('정말 삭제하시겠습니까?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  // "삭제" 버튼을 누를 때 해당 항목을 리스트에서 제거하고 화면을 업데이트
                                  setState(() {
                                    // 리스트에서 항목 삭제하는 코드 (여기서는 예시로 index를 이용)
                                    int index = menulists.indexOf(menu); // menu는 삭제하려는 항목
                                    if (index != -1) {
                                      menulists.removeAt(index);
                                    }
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('삭제'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('취소'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFFF5E5E), // 버튼 1의 배경색을 빨간색으로 설정
                    ),
                    child: Text('삭제'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
